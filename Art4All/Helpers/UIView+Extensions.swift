//
//  UIView+Extensions.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 23/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

extension UIView {
    func emulateButton(withDuration duration: Double,
                       starScale: (x: CGFloat, y: CGFloat),
                       finhishedScale: (x: CGFloat, y: CGFloat)) {
        UIView.animate(withDuration: duration * 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: starScale.x, y: starScale.y)
        }, completion: { _ in
            UIView.animate(withDuration: duration * 0.5) {
                self.transform = CGAffineTransform(scaleX: finhishedScale.x, y: finhishedScale.y)
            }
        })
    }
}
