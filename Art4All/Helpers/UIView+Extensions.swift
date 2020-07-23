//
//  UIView+Extensions.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 23/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

extension UIView {
    
    func emulateButton(withDuration duration: Double) {
        UIView.animate(withDuration: duration * 0.5, animations: { 
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: duration * 0.5) { 
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
