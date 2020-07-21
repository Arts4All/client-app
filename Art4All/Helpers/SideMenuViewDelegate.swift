//
//  SideMenuViewDelegate.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

@objc
protocol SideMenuViewDelegate: class {
    func back()
    @objc optional func save()
    @objc optional func delete()
}
