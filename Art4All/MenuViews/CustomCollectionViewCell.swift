//
//  MenuFinalizedCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    public func setUp(image: UIImage) {
        let imagemView = UIImageView(image: image)
        imagemView.frame = self.bounds
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        addSubview(imagemView)
    }
}
