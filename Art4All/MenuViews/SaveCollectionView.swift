//
//  SaveCollectionView.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class SaveCollectionView: UICollectionView {
    let cell = MenuSaveCollectionViewCell?.self
    var arrayOfImagesSave: [UIImage] = []
}

extension SaveCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 300, height: 165)
    }
}

extension SaveCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImagesSave.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellCollection = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MenuSaveCollectionViewCell",
                                 for: indexPath) as? MenuSaveCollectionViewCell else {
            return UICollectionViewCell()
        }
        cellCollection.canvasSaveImage = arrayOfImagesSave[indexPath.row]
        cellCollection.layer.cornerRadius = 20
        return cellCollection
    }
}
