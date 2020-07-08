//
//  CanvasNode.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 06/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

public class CanvasNode: UIButton {

    weak var visualGridElement: VisualGridElement?

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            self.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            self.layer.borderWidth = 3
            self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        } else {
            self.backgroundColor = visualGridElement?.nodeColor
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
