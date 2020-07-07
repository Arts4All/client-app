//
//  Environment.swift
//  Art4All
//
//  Created by Matheus Silva on 02/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

struct Environment {
    private static let PRODUCTION = false
    static var URL: String {
        return PRODUCTION ? "https://art4all.herokuapp.com" : "http://localhost:3000"
    }
    static var uuid: String {
        get {
            if let id = UserDefaults.standard.string(forKey: "uuid") {
                return id
            } else {
                let newValue = UUID().uuidString
                UserDefaults.standard.set(newValue, forKey: "uuid")
                return newValue
            }
        }
    }

}
