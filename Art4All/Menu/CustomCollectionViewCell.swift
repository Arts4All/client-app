//
//  MenuFinalizedCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private(set) var imagemView = UIImageView()
    var identifier = ""

    public func setUp(image: CellImageView) {
        imagemView = image
        imagemView.frame = self.bounds
        imagemView.contentMode = .scaleAspectFill
        imagemView.adjustsImageWhenAncestorFocused = true
        imagemView.clipsToBounds = false
        imagemView.layer.cornerRadius = 20
        imagemView.layer.masksToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        addSubview(imagemView)
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if self.isFocused {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } else {
              self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
}
