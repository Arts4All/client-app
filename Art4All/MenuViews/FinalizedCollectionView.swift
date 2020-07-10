//
//  FinalizedCollectionView.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class FinalizedCollectionView: UICollectionView {
    let cell = MenuFinalizedCollectionViewCell?.self
    var arrayOfImageFinalized: [UIImage] = []
    }

    extension FinalizedCollectionView: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: 300, height: 165)
        }
    }

extension FinalizedCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayOfImageFinalized.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSaveCollectionViewCell", for: indexPath) as! MenuSaveCollectionViewCell
        cellCollection.canvasSaveImage = arrayOfImageFinalized[indexPath.row]
        cellCollection.layer.cornerRadius = 20
        return cellCollection
    }
}
