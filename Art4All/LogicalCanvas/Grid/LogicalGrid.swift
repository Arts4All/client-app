//
//  LogicalGrid.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 05/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

public class LogicalGrid {

    public var elementsArray: [LogicalGridElement]
    public var rowSize: Int
    public var numberOfLines: Int
    private(set) var numberOfElements: Int

    init(rowSize: Int, numberOfLines: Int) {
        self.rowSize = rowSize
        self.numberOfLines = numberOfLines
        self.elementsArray = []
        self.numberOfElements = rowSize * numberOfLines
        for index in 0..<numberOfElements {
            guard let xPosition = findElementPosition(by: index)?.0 else {
                return
            }
            guard let yPosition = findElementPosition(by: index)?.1 else {
                return
            }
            let gridElement = LogicalGridElement(xPosition: xPosition, yPosition: yPosition)
            elementsArray.append(gridElement)
        }
    }

    func findElementPosition(by index: Int) -> (Int, Int)? {
        let index = index
        if index <= numberOfElements {
            let xPosition = index / rowSize
            let yPosition = index % rowSize
            return (xPosition, yPosition)
        }

        return nil
    }

    func findElementIndex(by xPosition: Int, by yPosition: Int) -> Int? {

        if xPosition >= 0 && yPosition >= 0 {
            let index = (xPosition * rowSize) + yPosition
            if index <= numberOfElements, xPosition < rowSize, yPosition < numberOfElements / rowSize {
                return index
            }
        }
        return nil
    }

    func calculateNumberOfLines () -> Int {
        let lines: Int
        lines = self.numberOfElements / self.rowSize
        return lines
    }
}
