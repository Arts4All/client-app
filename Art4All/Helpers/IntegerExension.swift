//
//  IntegerExension.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 22/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

extension Array {
        
    func transformTo<Generic>(conversion: (Element) -> Generic) -> [Generic] {
        
        var genericArray: [Generic] = []
        
        for element in self {
            let genericElement = conversion(element)
            
            genericArray.append(genericElement)
        }
        return genericArray
    }
}
