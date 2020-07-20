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
    public func imageFromWeb(urlNamed url: String) {
        self.image = nil
        let activityIndicator = self.activityIndicator
        DispatchQueue.main.async { activityIndicator.startAnimating() }
        guard let url = URL(string: url) else {
            NSLog("Error: Url para baixar imagem inválida")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            if error != nil {
                NSLog("Error: \(error as Any)")
                return
            }

            DispatchQueue.main.async(execute: {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()

                let image = UIImage(data: data!)
                if self.animationImages != nil {
                    self.animationImages?.removeAll()
                }
                self.image = image
            })

        }).resume()
    }
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
}
