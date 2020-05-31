//
//  BorderedUIView.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedUIView: UIView {
    @IBInspectable var _borderWitdh: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = _borderWitdh
        }
    }

    @IBInspectable var _borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = _borderColor.cgColor
        }
    }

    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
}
