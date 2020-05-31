//
//  UIView+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func setGradientBackround(from colors: UIColor...) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
