//
//  MenuFinalizedCollectionViewCell.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {
    private(set) var imagemView = UIImageView()
    var identifier = ""

    public func setUp(imageView: CellImageView, index: Int, web: Bool) {
        imagemView = imageView
        imagemView.frame = self.bounds
        imagemView.contentMode = .scaleAspectFill
        imagemView.adjustsImageWhenAncestorFocused = true
        imagemView.clipsToBounds = false
        imagemView.layer.cornerRadius = 20
        imagemView.layer.masksToBounds = true
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.loadImage(index: index, web: web)
        addSubview(imagemView)
    }
    private func loadImage(index: Int, web: Bool) {
        if self.imagemView.image == nil && web {
            DispatchQueue.main.async {
                let url = Environment.URL + "/canvas/image/50/\(index)"
                self.imagemView.sd_imageIndicator = SDWebImageActivityIndicator.medium
                self.imagemView.sd_setImage(with: URL(string: url))
            }
        }
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
