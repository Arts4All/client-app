//
//  MenuFinalizedCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var imagemView = UIImageView()
    public func setUp(image: UIImageView) {
        imagemView = image
        imagemView.frame = self.bounds
        imagemView.contentMode = .scaleAspectFill
        imagemView.adjustsImageWhenAncestorFocused = true
        imagemView.clipsToBounds = false
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        addSubview(imagemView)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) { }
}
