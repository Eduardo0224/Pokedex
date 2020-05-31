//
//  String+Extensions.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

extension String {
    var firstUppercased: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
