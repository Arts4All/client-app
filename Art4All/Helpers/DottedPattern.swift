//
//  DottedPattern.swift
//  Art4All
//
//  Created by Matheus Silva on 22/07/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit

extension UIView {
    func addDashBorder(color: UIColor) {
        let const: CGFloat = 5
        let shapeLayer: CAShapeLayer = CAShapeLayer()

        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - const, height: frameSize.height - const)

        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2,
                                      y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = const
        shapeLayer.lineDashPattern = [8, 4.8]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        self.layer.masksToBounds = false
        self.layer.addSublayer(shapeLayer)
    }
    func removeDashBorder() {
        self.layer.sublayers?.removeAll()
    }
}
