//
//  CustomMenuButton.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 24/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class CustomMenuButton: UIButton {
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } else {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
}
