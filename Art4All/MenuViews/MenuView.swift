//
//  BackGroundImagemView.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuView: UIView {

    var classSave = SaveCollectionView()
    var classFinalized = FinalizedCollectionView()
    var backgroundImageView = UIImageView()
    var playButton = UIButton()
    var saveLabel = UILabel()
    var finalizedLabel = UILabel()
    var saveCollectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout.init())
    let finalizedCollectionView = UICollectionView(frame: CGRect.zero,
                                                   collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()

      override init(frame: CGRect) {
      super.init(frame: frame)
        setbackgroundImage()
        setPlayButton()
        setSaveLabel()
        setFinalizedLabel()
        layout.scrollDirection = .vertical
        saveCollectionView.backgroundView = .none
        self.saveCollectionView.setCollectionViewLayout(layout, animated: true)
        self.addSubview(saveCollectionView)
        finalizedCollectionView.backgroundView = .none
        self.finalizedCollectionView.setCollectionViewLayout(layout, animated: true)
        self.addSubview(finalizedCollectionView)
        setSaveCollectionView()
        setFinalizedCollectionView()
    }

    func setPlayButton() {
        let imageButton = UIImage(named: "buttonPlayDisabled.png")
        playButton.setImage(imageButton, for: .normal)
        let xposition = (UIScreen.main.bounds.size.width/2) - (playButton.frame.size.width/2)
        let yposition = (UIScreen.main.bounds.size.height/2) - (playButton.frame.size.height/2) - 175
        playButton.frame = CGRect(x: xposition, y: yposition, width: 96, height: 94)
        self.addSubview(playButton)
    }

    func setSaveLabel() {
        saveLabel.text = "Salvos"
        saveLabel.font = UIFont(name: "Apple ][", size: 48)
        saveLabel.textColor = .white
        saveLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 160).isActive = true
        saveLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56).isActive = true
        saveLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        saveLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.addSubview(saveLabel)
    }

    func setSaveCollectionView() {
        saveCollectionView.register(MenuSaveCollectionViewCell.self,
                                    forCellWithReuseIdentifier: "MenuSaveCollectionViewCell")
        saveCollectionView.delegate = classSave.delegate
        saveCollectionView.dataSource = classSave.dataSource
        saveCollectionView.showsHorizontalScrollIndicator = false
        saveCollectionView.topAnchor.constraint(equalTo: saveLabel.bottomAnchor, constant: 30).isActive = true
        saveCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56).isActive = true
        saveCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        saveCollectionView.heightAnchor.constraint(equalToConstant: 166).isActive = true
    }

    func setFinalizedLabel() {
        finalizedLabel.text = "Finalizados"
        finalizedLabel.font = UIFont(name: "Apple ][", size: 48)
        finalizedLabel.topAnchor.constraint(equalTo: saveCollectionView.bottomAnchor, constant: 40).isActive = true
        finalizedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56).isActive = true
        finalizedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        finalizedLabel.heightAnchor.constraint(equalToConstant: 54).isActive = true
        finalizedLabel.frame = CGRect(x: 56, y: 845, width: 800, height: 54)
        finalizedLabel.textColor = .white
        self.addSubview(finalizedLabel)
    }

    func setFinalizedCollectionView() {
        self.finalizedCollectionView.register(MenuFinalizedCollectionViewCell.self,
                                              forCellWithReuseIdentifier: "MenuFinalizedCollectionViewCell")
        finalizedCollectionView.delegate = classFinalized.delegate
        finalizedCollectionView.dataSource = classFinalized.dataSource
        finalizedCollectionView.showsHorizontalScrollIndicator = false
        finalizedCollectionView.topAnchor.constraint(equalTo: finalizedLabel.bottomAnchor, constant: 30).isActive = true
        finalizedCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56).isActive = true
        finalizedCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -56).isActive = true
        finalizedCollectionView.heightAnchor.constraint(equalToConstant: 166).isActive = true
    }

    func setbackgroundImage() {
        let imageName = "colors.png"
        let image = UIImage(named: imageName)
        backgroundImageView = UIImageView(image: image!)
        backgroundImageView.frame = CGRect(x: 0, y: 0,
                                           width: UIScreen.main.bounds.width,
                                           height: UIScreen.main.bounds.height)
        backgroundImageView.contentMode = .scaleAspectFill
        self.addSubview(backgroundImageView)
        let coverLayer = CALayer()
        coverLayer.frame = backgroundImageView.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.4
        backgroundImageView.layer.addSublayer(coverLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
