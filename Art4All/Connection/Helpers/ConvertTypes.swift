//
//  ConvertTypes.swift
//  Art4All
//
//  Created by Matheus Silva on 07/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit
struct ConvertTypes {
    static func transformArrayInColor(array: [[String]]) -> [[UIColor]] {
        array.map({$0.map({$0.getColor()!})})
    }
}

extension String {
    func getColor() -> UIColor? {
        let array = self.split(separator: ",")

        let redString = String(array[0]).trimmingCharacters(in: .whitespacesAndNewlines)
        let greenString = String(array[1]).trimmingCharacters(in: .whitespacesAndNewlines)
        let blueString = String(array[2]).trimmingCharacters(in: .whitespacesAndNewlines)

        guard
            let redInteger = Int(redString),
            let greenInteger = Int(greenString),
            let blueInteger = Int(blueString)
            else {
                return nil
        }

        return UIColor(
            red: CGFloat(redInteger)/255,
            green: CGFloat(greenInteger)/255,
            blue: CGFloat(blueInteger)/255,
            alpha: 1
        )
    }
}

typealias MapColors = [[UIColor]]

extension MapColors {
    func getProperties() -> (rowSize: Int, numberOfLines: Int) {
        return (
            rowSize: self[0].count,
            numberOfLines: self.count
        )
    }
}
