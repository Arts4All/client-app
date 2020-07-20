//
//  Loading.swift
//  Art4All
//
//  Created by Rayane Xavier on 17/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//
import UIKit

extension UIView {
    func showLoading() {
        DispatchQueue.main.async {
            let loadingView = UIView(frame: self.bounds)
            loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            let animation = UIActivityIndicatorView(style: .large)
            animation.startAnimating()
            animation.center = loadingView.center
            loadingView.tag = 999
            DispatchQueue.main.async {
                loadingView.addSubview(animation)
                self.addSubview(loadingView)
            }
        }
    }
    func removeLoading() {
        for view in self.subviews {
            print(view.tag)
        }
        self.viewWithTag(999)?.removeFromSuperview()
    }
}
