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
        imagemView.contentMode = .scaleAspectFit
        imagemView.adjustsImageWhenAncestorFocused = true
        imagemView.clipsToBounds = false
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        addSubview(imagemView)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        coordinator.addCoordinatedAnimations({

            if self.isFocused {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
              self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }

        }, completion: nil)
    }
}
