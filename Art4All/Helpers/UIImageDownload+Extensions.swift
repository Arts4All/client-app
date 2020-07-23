//
//  UIImageDownload+Extensions.swift
//  Art4All
//
//  Created by Matheus Silva on 20/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else {
            NSLog("Error: Url para baixar imagem inválida")
            return
        }
        self.showLoading(.medium)
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.removeLoading()
                    }
                }
            }
        }
    }
}
