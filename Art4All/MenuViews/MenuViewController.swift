//
//  MenuViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    lazy var menu: MenuView = MenuView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(menu)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.menu.setupViews()
    }
}
