//
//  SideMenuViews.swift
//  Art4All
//
//  Created by Rayane Xavier on 15/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class SideMenu: UIView {
    var imageView = UIImageView()
    var image = UIImage()
    var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }

    convenience init(frame: CGRect, image: UIImage, text: String) {
        var frame = frame
        self.init(frame: frame)
        let heightScreen = UIScreen.main.bounds.size.height
        frame.size.height = heightScreen/4
        setImage(image: image)
        setLabel(text: text)
    }

    func setupViews() {
        setConstraintsImageView()
        setConstraintsLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setImage(image: UIImage) {
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }

    func setLabel(text: String) {
        label.text = text
        label.font = UIFont(name: "Apple ][", size: 24)
        label.textColor = .gray
        label.textAlignment = .center
        label.lineBreakMode = .byClipping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
    }

    func setConstraintsImageView() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.widthAnchor)
            ]
        NSLayoutConstraint.activate(constraints)
    }

    func setConstraintsLabel() {
        let constraints = [
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 45),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override var canBecomeFocused: Bool {
        return true
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

        coordinator.addCoordinatedAnimations({

            if self.isFocused {
                self.backgroundColor = .gray
                self.label.textColor = .white
            } else {
                self.backgroundColor = .white
                self.label.textColor = .gray
            }
        }, completion: nil)
    }
}
