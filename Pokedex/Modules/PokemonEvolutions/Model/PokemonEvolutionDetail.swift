//
//  PokemonEvolutionDetail.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct PokemonEvolutionDetail: Codable {
    let minLevel: Int

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
    }
}
