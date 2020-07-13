//
//  MenuViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    lazy var menu: MenuView = MenuView(frame: view.frame)
    private let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "aslam"))
    private let playButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpViews()
        self.view.addSubview(menu)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.menu.setupViews()
    }

    private func setUpViews() {
        setBackgroundImage()
    }

    private func setBackgroundImage() {
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill

        let coverLayer = CALayer()
        coverLayer.frame = backgroundImageView.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.4
        backgroundImageView.layer.addSublayer(coverLayer)
        self.view.addSubview(backgroundImageView)
    }
    // MARK: Play Button
    private func setPlayButton() {
        let imageButton = #imageLiteral(resourceName: "aslam")
        playButton.setImage(imageButton, for: .normal)
        self.view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupViewPlayButton() {
        let constraints = [
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
