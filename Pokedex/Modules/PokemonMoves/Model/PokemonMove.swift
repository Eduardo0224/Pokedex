//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct PokemonMove: Codable {
    let move: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case move
    }
}
