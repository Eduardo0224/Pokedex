//
//  UISearchBar+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view: UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}

