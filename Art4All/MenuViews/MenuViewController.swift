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
    private let playButton = UIButton(type: .custom)
    private let buttonLabel: UILabel = UILabel()
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
           return [playButton]
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.view.addSubview(savedView)
        self.view.addSubview(finishedView)
        self.view.addSubview(playButton)
        self.view.addSubview(buttonLabel)
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
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
        setButtonLabel()
    }

    private func setUpViews() {
        self.setupViewView(view: savedView, constant: 42)
        self.setupViewView(view: finishedView, constant: 333)
        setPlayButtonPosition()
        setLabelPosition()
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

    // MARK: Button Label
    private func setButtonLabel() {
         buttonLabel.text = "Entrar no canvas"
         buttonLabel.font = UIFont(name: "Apple ][", size: 24)
         buttonLabel.textColor = .white
     }

     private func setLabelPosition() {
         buttonLabel.translatesAutoresizingMaskIntoConstraints = false
         let constraints = [
             buttonLabel.centerYAnchor.constraint(equalTo: playButton.bottomAnchor,
                                                 constant: 30),
             buttonLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
             buttonLabel.widthAnchor.constraint(equalTo: buttonLabel.widthAnchor),
             buttonLabel.heightAnchor.constraint(equalTo: buttonLabel.heightAnchor)
         ]
         NSLayoutConstraint.activate(constraints)
     }
    // MARK: Play Button
    private func setPlayButton() {

        setupPlayButtonAction()
        let imageButton = #imageLiteral(resourceName: "buttonPlayDisable")
        let imageButtonSelect = #imageLiteral(resourceName: "buttonPlayEnabled")
        playButton.setImage(imageButton, for: .normal)
        playButton.setImage(imageButtonSelect, for: .highlighted)
        playButton.setImage(imageButtonSelect, for: .focused)
        playButton.tintColor = .white
    }

    private func setupPlayButtonAction() {
        playButton.addTarget(self, action: #selector(actionButton), for: .primaryActionTriggered)
    }

    private func setPlayButtonPosition() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,
                                                constant: -212),
            playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 100)
        ]
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
            view.heightAnchor.constraint(equalToConstant: 265)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func actionButton() {
        let canvasViewController = CanvasViewController()
        self.navigationController?.pushViewController(canvasViewController, animated: true)
    }
}
