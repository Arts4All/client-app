//
//  SaveCollectionView.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    public var images: [UIImageView] = []

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

    static func loadCoreData() -> [UIImageView] {
        var savedImages: [UIImageView] = []
        let coreDataController = CanvasImageCoreDataController()
        do {
            let canvasImages = try coreDataController.read()
            for canvasImage in canvasImages {
                let data = canvasImage.data
                if let savedImage = UIImage(data: data) {
                    let imageView = UIImageView()
                    imageView.image = savedImage
                    savedImages.append(imageView)
                }
                print(DAOError.invalidData(description: "Failed to transform data in UIImage"))
            }
        } catch {
            print(DAOError.internalError(description: "Failed to read core data"))
        }
        return savedImages
    }
    static func loadFromWeb(scale: Int) -> [UIImageView] {
        var webImages = [UIImageView]()
        let url = Environment.URL + "/canvas/image/\(scale)/"
        for index in 0..<20 {
            let imageView = UIImageView()
            imageView.imageFromWeb(urlNamed: url + String(index))
            webImages.append(imageView)
        }
        return webImages
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
