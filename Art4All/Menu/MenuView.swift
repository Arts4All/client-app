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
    lazy var canvas = CustomCollectionView(frame: self.frame,
                                           collectionViewLayout: layout,
                                           delegateView: self)
    private  var delegateView: CustomCollectionViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout.scrollDirection = .horizontal
    }
    convenience init(frame: CGRect,
                     title: String,
                     images: CellImagesViews,
                     delegateView: CustomCollectionViewDelegate,
                     web: Bool) {
        var frame = frame
        self.init(frame: frame)
        frame.size.height = 252
        setTitle(title: title)
        canvas.webImage = web
        setCollectionView(images: images)
        self.delegateView = delegateView
    }

    func setupViews() {
        setViewTitle()
        setupViewCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Title
    private func setTitle(title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Apple ][", size: 36)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    private func setViewTitle() {
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    // MARK: Collection
    private func setCollectionView(images: CellImagesViews) {
        canvas.images = images
        canvas.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(canvas)
    }
    private func setupViewCollectionView() {
        let constraints = [
            canvas.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
            canvas.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            canvas.widthAnchor.constraint(equalTo: self.widthAnchor),
            canvas.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MenuView: CustomCollectionViewDelegate {
    func visualization(image: UIImage, identifier: String) {
        self.delegateView?.visualization(image: image, identifier: identifier)
    }
}
