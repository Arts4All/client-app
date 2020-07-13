//
//  MenuViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var savedView: MenuView!
    private var finishedView: MenuView!
    private let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "aslam"))
    private let playButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.view.addSubview(savedView)
        self.view.addSubview(finishedView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.setUpViews()
        self.savedView.setupViews()

    }
    private func setUp() {
        setBackgroundImage()
        setUpSavedCanvas()
//        setupSavedView()

    }
    private func setUpViews() {
//        setupViewSavedView()
        self.setupViewView(view: savedView, constant: -400)
        self.setupViewView(view: finishedView, constant: 40)
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
    // MARK: Saved Canvas
//    private func setupSavedView() {
//        savedView = MenuView(frame: self.view.frame, title: "Salvos", images: [#imageLiteral(resourceName: "aslam")])
//        savedView.translatesAutoresizingMaskIntoConstraints = false
//    }
//    private func setupViewSavedView() {
//        let constraints = [
//            savedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            savedView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            savedView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            savedView.heightAnchor.constraint(equalToConstant: 252)
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
    // MARK: Canvas
    private func setUpSavedCanvas() {
        self.savedView = self.setupView(view: savedView, title: "Salvos", images: [#imageLiteral(resourceName: "aslam")])
        self.finishedView = self.setupView(view: finishedView, title: "asda", images: [#imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam")])
    }
    private func setupView(view: MenuView?, title: String, images: [UIImage]) -> MenuView? {
        var view = view
        view = MenuView(frame: self.view.frame, title: title, images: images)
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    private func setupViewView(view: MenuView, constant: CGFloat) {
        let constraints = [
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: constant),
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            view.heightAnchor.constraint(equalToConstant: 252)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
