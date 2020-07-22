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

    var paintColor: UIColor = #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.4196078431, alpha: 1)

    var isSelected: Bool = false

    weak var visualGridElement: VisualGridElement?

    public override var canBecomeFocused: Bool {
        return true
    }

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            self.layer.borderWidth = 4
            self.layer.borderColor = paintColor.cgColor
            self.isSelected = true

        } else {
            self.layer.borderWidth = 0.6
            self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.isSelected = false
        }
    }
}
