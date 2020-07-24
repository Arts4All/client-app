//
//  SaveCollectionView.swift
//  testLayout
//
//  Created by Rayane Xavier on 08/07/20.
//  Copyright © 2020 Rayane Xavier. All rights reserved.
//

import UIKit

protocol CustomCollectionViewDelegate: class {
    func visualization(image: UIImage, identifier: String)
}
class CustomCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    public var imagesView: CellImagesViews = []
    private weak var delegateView: CustomCollectionViewDelegate?
    public var webImage = false

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        var frame = frame
        frame.size.height = 166
        super.init(frame: frame, collectionViewLayout: layout)
        self.setUp()
        self.delegate = self
        self.dataSource = self
    }

    convenience init(frame: CGRect,
                     collectionViewLayout layout: UICollectionViewLayout,
                     delegateView: CustomCollectionViewDelegate) {
        self.init(frame: frame, collectionViewLayout: layout)
        self.delegateView = delegateView
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUp() {
        self.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }

    static func loadCoreData() -> CellImagesViews {
        var savedImages: CellImagesViews = []
        let coreDataController = CanvasImageCoreDataController()
        do {
            let canvasImages = try coreDataController.read()
            for canvas in canvasImages {
                let cell = CellImageView(frame: .zero, canvas: canvas)
                savedImages.append(cell)
            }
        } catch {
            print(DAOError.internalError(description: "Failed to read core data"))
        }
        return savedImages.reversed()
    }
    static func loadFromWeb() -> CellImagesViews {
        var webImages = CellImagesViews()
        for index in 0...9 {
            let imageView = CellImageView(frame: .zero)
            imageView.image = nil
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = imagesView[indexPath.row]
        self.delegateView?.visualization(image: cell.image ?? UIImage(), identifier: cell.identifier)
    }
}

extension CustomCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesView.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellCollection = collectionView
            .dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell",
                                 for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cellCollection.setUp(imageView: imagesView[indexPath.row], index: indexPath.row)
        return cellCollection
    }
}
