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

    init(rowSize: Int, numberOfLines: Int, squareSize: Int) {

        self.grid = LogicalGrid(rowSize: rowSize, numberOfLines: numberOfLines)
        self.numberOfLines = numberOfLines
        self.numberOfColumns = rowSize
        self.squareSize = squareSize
        self.numberOfElements = numberOfColumns * numberOfLines
        createTiles()
    }

    func createTiles() {

        for xPosition in 0..<numberOfColumns {
            for yPosition in 0..<numberOfLines {
                let tileNode = VisualGridElement(xPosition: xPosition, yPosition: yPosition, squareSize: squareSize)
                tileNode.hasBeenModified = false
                tiles.append(tileNode)
            }
        }
    }
}
