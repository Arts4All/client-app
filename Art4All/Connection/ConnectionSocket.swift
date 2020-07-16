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
    public let manager = SocketManager(socketURL: URL(string: Environment.URL)!,
                                config: [.log(false), .compress])
    private lazy var socket = manager.defaultSocket

    private init() {
        socket.on(clientEvent: .connect) { _, _ in
            self.join()
        }
        self.registerOn()
        socket.connect()
    }
    public func setupDelegate(delegate: ConnectionSocketDelegate) {
        self.delegate = delegate
    }

    private func registerOn() {
        self.joined()
        self.drawToClient()
        self.end()
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

    private func joined() {
        self.socket.on("joined") { (data, _) in
            guard JoinComunication.validate(data: data[0]) else {
                return
            }
            guard let map = JoinComunication.getMap(mapString: data[1]) else {
                return
            }
            let mapColors = ConvertTypes.transformArrayInColor(array: map)
            let properties = mapColors.getProperties()
            self.delegate?.setupGrid(properties.rowSize,
                                     properties.numberOfLines,
                                     mapColors)
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
            self.delegate?.changeTileState(color: color,
                                           position: (xPosition: xPosition,
                                                      yPosition: yPosition))
        }
    }

    private func end() {
        self.socket.on("end") { (_, _) in
            print("acabou")
        }
    }
}
