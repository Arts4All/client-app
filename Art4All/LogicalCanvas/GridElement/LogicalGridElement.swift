//
//  LogicalGridElement.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 05/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

public class LogicalGridElement {

    public var xPosition: Int
    public var yPosition: Int
    public var color: String?

    init(xPosition: Int, yPosition: Int) {
        self.xPosition = xPosition
        self.yPosition = yPosition
    }

    convenience init(xPosition: Int, yPosition: Int, color: String) {
        self.init(xPosition: xPosition, yPosition: yPosition)
        self.color = color
    }
}
