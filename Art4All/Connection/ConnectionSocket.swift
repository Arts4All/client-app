//
//  ConnectionSocket.swift
//  Art4All
//
//  Created by Matheus Silva on 07/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import SocketIO
import UIKit

protocol ConnectionSocketDelegate: class {
    func setupGrid(_ numberOfColumns: Int,
                   _ numberOfLines: Int,
                   _ mapColors: MapColors)
    func changeTileState(color: UIColor,
                         position: (xPosition: Int, yPosition: Int))
}

final class ConnectionSocket {

    weak var delegate: ConnectionSocketDelegate?

    public static let shared: ConnectionSocket = ConnectionSocket()
    private let uuid: String = UUID().uuidString

    //Manager SocketIO
    let manager = SocketManager(socketURL: URL(string: Environment.URL)!,
                                config: [.log(false), .compress])
    lazy var socket = manager.defaultSocket

    private init() {
        // Do any additional setup after loading the view.
        socket.on(clientEvent: .connect) { _, _ in
            print("socket connected")
            self.join()
        }

        socket.on(clientEvent: .disconnect) { _, _ in
            print("socket disconnect")
        }
        self.setupOn()
        self.drawToClient()
        socket.connect()
    }

    private func setupOn() {
        self.socket.on("joined") { (data, _) in
            guard JoinComunication.validate(data: data[0]) else {
                print("nao sou eu")
                return
            }
            print("sou eu")
            guard let map = JoinComunication.getMap(mapString: data[1]) else {
                print("cade o mapa")
                return
            }
            let mapColors = ConvertTypes.transformArrayInColor(array: map)
            let properties = mapColors.getProperties()
            self.delegate?.setupGrid(properties.rowSize,
                                     properties.numberOfLines,
                                     mapColors)
        }
    }

    private func join() {
        self.socket.emitWithAck("join", Environment.uuid).timingOut(after: 1) { data in
            print(data)
        }
    }

    func drawToServer(color: UIColor, _ position: (xPosition: Int, yPosition: Int)) {
        guard let rgb = color.rgb() else { return }
        let stringColor = "\(rgb.red), \(rgb.green), \(rgb.blue)"
        self.socket.emitWithAck("drawToServer",
                                position.xPosition,
                                position.yPosition,
                                stringColor
                                ).timingOut(after: 1) { data in
            print(data)
        }
    }

    private func drawToClient() {
        self.socket.on("drawToClient") { (data, _) in
            guard
                let xPosition = data[0] as? Int,
                let yPosition = data[1] as? Int,
                let colorString = data[2] as? String,
                let color = colorString.getColor()
            else {
                print("Playload incorreto")
                return
            }
            print(xPosition, yPosition)
            self.delegate?.changeTileState(color: color,
                                           position: (xPosition: xPosition,
                                                      yPosition: yPosition))
        }
    }

    func setupDelegate(delegate: ConnectionSocketDelegate) {
        self.delegate = delegate
    }
}