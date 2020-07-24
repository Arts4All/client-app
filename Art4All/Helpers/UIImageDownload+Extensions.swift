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
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self?.image = image
                        self?.removeLoading()
                }
            }
        }
    }
}
