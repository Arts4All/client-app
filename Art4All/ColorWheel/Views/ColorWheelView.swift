//
//  ColorWheelView.swift
//  Art4All
//
//  Created by Rayane Xavier on 15/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

class ColorWheelView: UIView {

    var colorCollectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewFlowLayout())
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    weak var colorWheelDelegate: ColorWheelDelegate?
    
    var arrayOfColors: [UIColor] = [#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.7803921569, green: 0, blue: 0.2235294118, alpha: 1), #colorLiteral(red: 1, green: 0.3411764706, blue: 0.2, alpha: 1), #colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1), #colorLiteral(red: 0.6784313725, green: 0.831372549, blue: 0.3607843137, alpha: 1), #colorLiteral(red: 0.1647058824, green: 0.4823529412, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.4196078431, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.09411764706, blue: 0.2862745098, alpha: 1)]

      override init(frame: CGRect) {
      super.init(frame: frame)
        setBackground()
        layout.scrollDirection = .vertical
        self.colorCollectionView.setCollectionViewLayout(layout, animated: true)
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
        self.colorCollectionView.backgroundColor = UIColor.white
        self.addSubview(self.colorCollectionView)
        setupCollectionView()
    }
    
    convenience init(frame: CGRect, viewControllerDelegate: ColorWheelDelegate) {
        self.init(frame: frame)
        
        self.colorWheelDelegate = viewControllerDelegate
    }

    func setupCollectionView() {
        self.colorCollectionView.register(ColorWheelCollectionViewCell.self,
                                          forCellWithReuseIdentifier: "ColorWheelCollectionViewCell")
        self.colorCollectionView.showsVerticalScrollIndicator = false
        let viewSize = self.frame
        self.colorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.colorCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.colorCollectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.colorCollectionView.widthAnchor.constraint(equalToConstant: viewSize.width * 0.4),
            self.colorCollectionView.heightAnchor.constraint(equalToConstant: viewSize.width * 0.4)
        ]
        NSLayoutConstraint.activate(constraints)
        self.addSubview(self.colorCollectionView)
    }

    func setBackground() {
        let coverLayer = CALayer()
        coverLayer.frame = self.bounds
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.4
        self.layer.addSublayer(coverLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
