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
        imagemView.layer.cornerRadius = 20
        imagemView.layer.masksToBounds = true
        self.backgroundColor = .clear
        addSubview(imagemView)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            } else {
              self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
}
