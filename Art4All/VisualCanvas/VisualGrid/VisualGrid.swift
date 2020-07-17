//
//  VisualGrid.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

class VisualGrid {

    var tiles: [VisualGridElement] = []
    var grid: LogicalGrid
    var numberOfLines: Int
    var numberOfColumns: Int
    var numberOfElements: Int
    var squareSize: Int

    init(numberOfColumns: Int, numberOfLines: Int, squareSize: Int, mapColors: MapColors) {

        self.grid = LogicalGrid(numberOfColumns: numberOfColumns, numberOfLines: numberOfLines)
        self.numberOfLines = numberOfLines
        self.numberOfColumns = numberOfColumns
        self.squareSize = squareSize
        self.numberOfElements = numberOfColumns * numberOfLines
        createTiles(mapColors)
    }

    func createTiles(_ mapColors: MapColors) {
        for yPosition in 0..<numberOfLines {
            for xPosition in 0..<numberOfColumns {
                let tileNode = VisualGridElement(xPosition: xPosition,
                                                 yPosition: yPosition, squareSize: squareSize)

                let color = mapColors[yPosition][xPosition]

                if color != .baseColor {
                    tileNode.changeTileState(state: .modified, newColor: color)
                }
                tiles.append(tileNode)
            }
        }
    }
    func getSelected() -> CanvasNode? {
        guard let gridElement = tiles.first(where: {$0.node.isSelected==true}) else {
            return  nil
        }
        return gridElement.node
    }
    func selectedColor(color: UIColor) {
        tiles.forEach { elem in
            elem.node.paintColor = color
        }
    }
}
