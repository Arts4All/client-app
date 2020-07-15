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
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        addSubview(imagemView)
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        if context.nextFocusedView == self {
            self.layer.borderWidth = 3
            self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}
