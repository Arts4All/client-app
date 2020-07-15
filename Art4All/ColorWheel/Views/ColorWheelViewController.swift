//
//  File.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 15/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class ColorWheelViewController: UIViewController {
    var menuColor: ColorWheelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuColor = ColorWheelView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(menuColor)
    }
    
}
