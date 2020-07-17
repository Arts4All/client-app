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

    override var canBecomeFocused: Bool {
        return true
    }

    public override func didUpdateFocus(in context: UIFocusUpdateContext,
                                        with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        if context.nextFocusedView == self {
            self.layer.borderWidth = 8
            self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.isSelected = true

        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.isSelected = false
        }
    }

}
