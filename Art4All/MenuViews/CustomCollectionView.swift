//
//  SaveCollectionView.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    public var images: [UIImage] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        var frame = frame
        frame.size.height = 166
        super.init(frame: frame, collectionViewLayout: layout)
        self.setUp()
        self.delegate = self
        self.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUp() {
        self.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
}

extension CustomCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 300, height: 165)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}

extension CustomCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellCollection = collectionView
            .dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell",
                                 for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cellCollection.setUp(image: images[indexPath.row])
        return cellCollection
    }
}
