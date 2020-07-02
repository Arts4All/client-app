//
//  ViewController.swift
//  Art4All
//
//  Created by Matheus Silva on 02/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    @IBOutlet weak var messageText: UITextField!

    //Manager SocketIO
    let manager = SocketManager(socketURL: URL(string: Server.URL)!,
                                config: [.log(false), .compress])
    lazy var socket = manager.defaultSocket

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        socket.on(clientEvent: .connect) { _, _ in
            print("socket connected")
        }

        socket.on(clientEvent: .disconnect) { _, _ in
            print("socket disconnect")
        }

        socket.connect()
    }

    @IBAction func sendMessage(_ sender: Any) {
        let message = [
            "name": "Guedes",
            "text": self.messageText.text ?? "BATATA"
        ]
        self.socket.emitWithAck("msgToServer", message).timingOut(after: 1) { _ in
            print("enviou")
        }
    }
}
