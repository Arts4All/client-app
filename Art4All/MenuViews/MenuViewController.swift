//
//  MenuViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var menu: MenuView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = MenuView(frame: CGRect.zero)
        self.view.addSubview(menu)
    }
}
