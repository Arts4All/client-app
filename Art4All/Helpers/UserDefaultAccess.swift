//
//  UserDefaultAccess.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 22/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

struct UserDefaultAccess {

    static var nodePositin: [Int] {
        get {
            let stringArray = UserDefaults.standard.stringArray(forKey: "nodePosition") ?? []
            let integerArray: [Int] = stringArray.transformTo {
                (Int($0) ?? 0)
            }
            return integerArray
        }
        set {
            let stringArray = newValue.transformTo {
                String($0)
            }
            UserDefaults.standard.set(stringArray, forKey: "nodePosition")
        }
    }

    static var paitingColor: UIColor? {
        get {
            let rgbString = UserDefaults.standard.string(forKey: "paitingColor")

            return rgbString?.getColor()
        }
        set {
            guard let newColor = newValue else {
                return
            }
            let rgbString = newColor.rgb()

            UserDefaults.standard.set(rgbString, forKey: "paitingColor")
        }
    }
}
