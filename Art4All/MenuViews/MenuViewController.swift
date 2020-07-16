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
    private let playButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.view.addSubview(savedView)
        self.view.addSubview(finishedView)
        self.view.addSubview(playButton)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.setUpViews()
        self.savedView.setupViews()
        self.finishedView.setupViews()

    }
    private func setUp() {
        setBackgroundImage()
        setPlayButton()
        setUpSavedCanvas()
    }

    private func setUpViews() {
        self.setupViewView(view: savedView, constant: 42)
        self.setupViewView(view: finishedView, constant: 333)
        setupViewPlayButton()
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

        setupPlayButtonAction()
        let imageButton = #imageLiteral(resourceName: "buttonPlayDisable")
        playButton.setImage(imageButton, for: .normal)
    }

    private func setupPlayButtonAction() {
        playButton.addTarget(self, action: #selector(actionButton), for: .primaryActionTriggered)
    }

    private func setupViewPlayButton() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,
                                                constant: -75),
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 150)        ]
        NSLayoutConstraint.activate(constraints)
    }
    // MARK: Canvas
    private func setUpSavedCanvas() {
        self.savedView = self.setupView(view: savedView, title: "Canvas Salvos", images: [#imageLiteral(resourceName: "aslam")])
        self.finishedView = self.setupView(view: finishedView, title: "Canvas Finalizados",
                                           images: [#imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam")])
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

    @objc func actionButton() {
        let canvasViewController = CanvasViewController()
        self.navigationController?.pushViewController(canvasViewController, animated: true)
    }
}
