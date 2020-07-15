//
//  CanvasNode.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

public class CanvasNode: UIButton, ColorWheelDelegate {
    
    var paintColor: UIColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

    weak var visualGridElement: VisualGridElement?
    
    func selectedColor(color: UIColor) {
        paintColor = color
    }

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            self.backgroundColor = paintColor
            self.layer.borderWidth = 3
            self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        } else {
            self.backgroundColor = visualGridElement?.nodeColor
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
