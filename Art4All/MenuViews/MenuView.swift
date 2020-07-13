//
//  BackGroundImagemView.swift
//  testLayout
//
//  Created by Rayane Xavier on 07/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class MenuView: UIView {

    public var titleLabel = UILabel()
    private let layout = UICollectionViewFlowLayout()
    private lazy var canvas = CustomCollectionView(frame: self.frame,
                                                        collectionViewLayout: layout)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
        setCollectionView(images: [#imageLiteral(resourceName: "aslam")])
    }

    func setupViews() {
        setupViewCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setTitle() { }

    private func setCollectionView(images: [UIImage]) {
        canvas.images = images
        canvas.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(canvas)
    }

    private func setupViewCollectionView() {
        let constraints = [
            canvas.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            canvas.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            canvas.heightAnchor.constraint(equalToConstant: canvas.frame.size.height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
