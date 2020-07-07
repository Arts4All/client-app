//
//  CanvasViewController.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {

    var grid: VisualGrid?
    var tiles: [VisualGridElement]?

    override func viewDidLoad() {
        super.viewDidLoad()

        grid = VisualGrid(rowSize: 10, numberOfLines: 10, squareSize: 50)

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
}
