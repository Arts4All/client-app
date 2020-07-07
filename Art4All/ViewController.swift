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

    var grid: VisualGrid?
    var tiles: [VisualGridElement]?

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

        let squareSize = 100

        grid = VisualGrid(rowSize: 10, numberOfLines: 10, squareSize: squareSize)

        guard let grid = grid else {
            return
        }

        tiles = grid.tiles

        guard let tiles = tiles else {
            return
        }

        for tile in tiles {
            self.view.addSubview(tile.tile)
        }
    }
    override func viewDidLayoutSubviews() {
        guard let tiles = tiles else {
            return
        }
        for tile in tiles {
            let uiTile = tile.tile
            uiTile.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                uiTile.widthAnchor.constraint(equalToConstant: uiTile.frame.width),
                uiTile.heightAnchor.constraint(equalToConstant: uiTile.frame.height),
                uiTile.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(tile.xPositionOnCanvas)),
                uiTile.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(tile.yPositionOnCanvas))
            ])
        }
    }
}
