//
//  CellImageView.swift
//  Art4All
//
//  Created by Matheus Silva on 21/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

class CellImageView: UIImageView {
    private(set) var identifier: String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, canvas: CanvasImage) {
        self.init(frame: frame)
        self.identifier = canvas.identifier
        if let savedImage = UIImage(data: canvas.data) {
            self.image = savedImage
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    
//    func loadImage(index: Int) {
//        guard image else { return }
//        DispatchQueue.main.async {
//            let url = Environment.URL + "/canvas/image/50/\(index)"
//            image.load(url: url)
//        }
//    }
}

typealias CellImagesViews = [CellImageView]
