//
//  MenuViewController.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {

    var savedView: MenuView!
    private var finishedView: MenuView!
    private let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "background_mennun"))
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
        backgroundImageView.contentMode = .scaleAspectFit
        view.backgroundColor = .backgroundColor
        let coverLayer = CALayer()
        coverLayer.frame = backgroundImageView.bounds
        coverLayer.backgroundColor = UIColor.backgroundColor.cgColor
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
                                                 constant: 50),
            buttonLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor),
            buttonLabel.widthAnchor.constraint(equalTo: buttonLabel.widthAnchor),
            buttonLabel.heightAnchor.constraint(equalTo: buttonLabel.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: Play Button
    private func setPlayButton() {
        setupPlayButtonAction()
        playButton.setImage(#imageLiteral(resourceName: "normal"), for: .normal)
        playButton.setImage(#imageLiteral(resourceName: "highlighted"), for: .highlighted)
        playButton.setImage(#imageLiteral(resourceName: "focused"), for: .focused)
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
        self.savedView = self.setupView(view: savedView, title: "Canvas Salvos",
                                        images: CustomCollectionView.loadCoreData())
        self.finishedView = self.setupView(view: finishedView, title: "Canvas Finalizados",
                                           images: CustomCollectionView.loadFromWeb(scale: 100))
    }
    private func setupView(view: MenuView?, title: String, images: CellImagesViews) -> MenuView? {
        var view = view
        view = MenuView(frame: self.view.frame,
                        title: title,
                        images: images,
                        delegateView: self)
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
        canvasViewController.delegate = self
        self.navigationController?.pushViewController(canvasViewController, animated: true)

    }
}

extension MenuViewController: ReloadControllerDelegate {
    func reload() {
        self.savedView.canvas.images = CustomCollectionView.loadCoreData()
        self.savedView.canvas.reloadData()
    }
}

extension MenuViewController: CustomCollectionViewDelegate {
    func visualization(image: UIImage, identifier: String) {
        let visualizationView = VisualizationController()
        visualizationView.setup(image: image, identifier: identifier, delegate: self)
        self.navigationController?.pushViewController(visualizationView, animated: true)
    }
}
