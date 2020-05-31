//
//  UIBarButtonItem.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    private struct attributes {
        static var actionKey: Void?
    }

    private var _action: () -> () {
        get {
            return objc_getAssociatedObject(self, &attributes.actionKey) as! () -> ()
        }
        set {
            objc_setAssociatedObject(self, &attributes.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(image: UIImage?, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(image: image, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }

    convenience init(title: String, style: UIBarButtonItem.Style, action: @escaping () -> ()) {
        self.init(title: title, style: style, target: nil, action: #selector(pressed))
        self.target = self
        self._action = action
    }

    @objc private func pressed(sender: UIBarButtonItem) {
        _action()
    }
}
