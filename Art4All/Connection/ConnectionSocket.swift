//
//  ConnectionSocket.swift
//  Art4All
//
//  Created by Matheus Silva on 07/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import SocketIO

final class ConnectionSocket {

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
        socket.connect()
    }
    func setupOn() {
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
            print(map)
        }
    }

    func join() {
        print(uuid)
        self.socket.emitWithAck("join", Environment.uuid).timingOut(after: 1) {
            data in
            print(data)
        }
    }
}
