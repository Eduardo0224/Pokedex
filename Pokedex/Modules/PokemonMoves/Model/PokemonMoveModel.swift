//
//  PokemonMoveModel.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct PokemonMoveModel: Codable {
    let type: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case type
    }
}
