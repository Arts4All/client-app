//
//  Colors.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

extension UIColor {
    func rgb() -> String? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0

        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)

            return "\(iRed), \(iGreen), \(iBlue)"
        } else {
            return nil
        }
    }
    static var baseColor: UIColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    static var backgroundColor: UIColor = UIColor(red: 0/255, green: 12/255, blue: 46/255, alpha: 1)
    static var deleteColor: UIColor = UIColor(red: 199/255, green: 0/255, blue: 57/255, alpha: 1)
}
