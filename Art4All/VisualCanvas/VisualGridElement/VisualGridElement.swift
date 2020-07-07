//
//  VisualGridElement.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

public class VisualGridElement: LogicalGridElement {

    var tile: CanvasNode
    var hasBeenModified: Bool
    var xPositionOnCanvas: Int
    var yPositionOnCanvas: Int
    var squareSize: Int

    init(xPosition: Int, yPosition: Int, squareSize: Int) {

        self.squareSize = squareSize

        self.xPositionOnCanvas = ((xPosition * squareSize))
        self.yPositionOnCanvas = ((yPosition * squareSize)) * -1

        let rect = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)

        self.hasBeenModified = false

        self.tile = CanvasNode(frame: rect)

        self.tile.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        self.tile.layer.borderWidth = CGFloat(squareSize/40)
        self.tile.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        self.tile.setTitle("Teste", for: .normal)

        super.init(xPosition: xPosition, yPosition: yPosition)

        self.tile.visualGridElement = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeTileState(state: TileStateEnum, newColor: UIColor) {
        switch state {
        case .intact:
            self.tile.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.hasBeenModified = false
        case .modified:
            self.tile.backgroundColor = newColor
            self.hasBeenModified = true
        }
    }
}
