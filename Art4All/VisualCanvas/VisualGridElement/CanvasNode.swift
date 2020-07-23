//
//  CanvasNode.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

public class CanvasNode: UIView {

    var paintColor: UIColor = #colorLiteral(red: 0.1647058824, green: 0.4823529412, blue: 0.6078431373, alpha: 1)

    var isSelected: Bool = false

    weak var visualGridElement: VisualGridElement?

    public override var canBecomeFocused: Bool {
        return true
    }

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            if self.backgroundColor?.rgb() == paintColor.rgb() {
                self.addDashBorder(color: .white)
            } else {
                self.addDashBorder(color: paintColor)
            }
            self.isSelected = true

        } else {
            self.removeDashBorder()
            self.isSelected = false
        }
    }
}
