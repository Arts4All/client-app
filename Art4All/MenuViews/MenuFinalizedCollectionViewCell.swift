//
//  MenuFinalizedCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuFinalizedCollectionViewCell: UICollectionViewCell {
    var canvasFinalizedImage: UIImage!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imagemView = UIImageView(image: canvasFinalizedImage)
        imagemView.frame = self.bounds
        addSubview(imagemView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
