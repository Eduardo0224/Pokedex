//
//  UITableView+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cell nib: String, withId id: String = "") {
        register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: id.isEmpty ? nib : id)
    }
}
