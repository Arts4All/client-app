//
//  BackGroundImagemView.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuView: UIView {

    private let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "aslam"))
    private let playButton = UIButton()
    private let saveLabel = UILabel()
    private let finalizedLabel = UILabel()
    private let layout = UICollectionViewFlowLayout()
    private lazy var savedCanvas = CustomCollectionView(frame: self.frame,
                                                        collectionViewLayout: layout)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage()
//        setPlayButton()
        setSaveLabel()
        setFinalizedLabel()
        setSavedCollectionView()
        setFinalizedCollectionView()
    }

    func setupViews() {
//        setupViewPlayButton()
        setupViewSavedCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setPlayButton() {
        let imageButton = #imageLiteral(resourceName: "aslam")
        playButton.setImage(imageButton, for: .normal)
        self.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupViewPlayButton() {
        let constraints = [
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setSaveLabel() { }

    private func setFinalizedLabel() { }

    private func setSavedCollectionView() {
        savedCanvas.images = [#imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam"), #imageLiteral(resourceName: "aslam")]
        self.addSubview(savedCanvas)
    }

    private func setupViewSavedCollectionView() {
        let constraints = [
            savedCanvas.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            savedCanvas.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            savedCanvas.widthAnchor.constraint(equalToConstant: 100),
            savedCanvas.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setFinalizedCollectionView() { }

    private func setBackgroundImage() {
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill

        let coverLayer = CALayer()
        coverLayer.frame = backgroundImageView.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.4
        backgroundImageView.layer.addSublayer(coverLayer)

        self.addSubview(backgroundImageView)
    }
}
