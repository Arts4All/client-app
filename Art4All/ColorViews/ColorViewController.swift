//
//  ColorViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    var menuColor: ColorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuColor = ColorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(menuColor)
    }
}
