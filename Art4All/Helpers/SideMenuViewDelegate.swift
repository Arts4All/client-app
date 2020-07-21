//
//  SideMenuViewDelegate.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

protocol SideMenuViewDelegate: class {
    func back()
    func save()
}

extension SideMenuViewDelegate {
    func delete() {}
}
