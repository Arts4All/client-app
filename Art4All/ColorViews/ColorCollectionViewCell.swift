//
//  ColorCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 09/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
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
