//
//  File.swift
//  Art4All
//
//  Created by Pedro Henrique Guedes Silveira on 15/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//


import UIKit

class ColorWheelCollectionViewCell: UICollectionViewCell {
    var view = UIView()

    override init(frame: CGRect) {
        view = UIView(frame: frame)
        super.init(frame: frame)
        view.frame = self.bounds
        addSubview(view)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
