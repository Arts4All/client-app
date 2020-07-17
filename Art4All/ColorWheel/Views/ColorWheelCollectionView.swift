//
//  File.swift
//  Art4All
//
//  Created by Rayane Xavier on 15/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

extension ColorWheelView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.colorWheelDelegate?.selectedColor(color: arrayOfColors[indexPath.row])
    }
}

extension ColorWheelView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = ((colorCollectionView.frame.width) - 100)/3
        return CGSize(width: size, height: size)
    }
}
extension ColorWheelView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfColors.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellCollection = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ColorWheelCollectionViewCell",
            for: indexPath) as? ColorWheelCollectionViewCell else {
            return UICollectionViewCell()
        }
        cellCollection.view.backgroundColor = arrayOfColors[indexPath.row]
        return cellCollection
    }
}
