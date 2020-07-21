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

    var node: CanvasNode
    var nodeColor: UIColor = .baseColor
    var hasBeenModified: Bool
    var xPositionOnCanvas: Int
    var yPositionOnCanvas: Int
    var squareSize: Int

    init(xPosition: Int, yPosition: Int, squareSize: Int) {

        self.squareSize = squareSize

        self.xPositionOnCanvas = ((xPosition * squareSize))
        self.yPositionOnCanvas = ((yPosition * squareSize))

        let rect = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)

        self.hasBeenModified = false

        self.node = CanvasNode()

        self.node.backgroundColor = nodeColor

        self.node.frame = rect

//        self.node.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.node.layer.borderWidth = 0.6
        self.node.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        super.init(xPosition: xPosition, yPosition: yPosition)

        self.node.visualGridElement = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeTileState(state: TileStateEnum, newColor: UIColor) {
        switch state {
        case .intact:
            self.nodeColor = .baseColor
            self.hasBeenModified = false
        case .modified:
            self.nodeColor = newColor
            self.hasBeenModified = true
        }
        self.node.backgroundColor = self.nodeColor
    }

}
