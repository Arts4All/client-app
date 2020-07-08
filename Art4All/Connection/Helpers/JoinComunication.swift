//
//  Map.swift
//  Art4All
//
//  Created by Matheus Silva on 07/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
struct JoinComunication {
    static func validate(data: Any) -> Bool {
        guard let identifier = data as? String else {
            return false
        }
        return identifier == Environment.uuid
    }

    static func getMap(mapString: Any) -> [[String]]? {
        guard let mapString = mapString as? String else {
            return nil
        }

        guard let map = try? JSONDecoder().decode([[String]].self,
                                                  from: mapString.data(using: .utf8)!) else {
            return nil
        }
        return map
    }
}
