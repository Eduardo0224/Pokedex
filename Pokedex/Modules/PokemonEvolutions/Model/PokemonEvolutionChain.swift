//
//  PokemonChainLink.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct PokemonEvolutionChain: Codable {
    let id: Int
    let chain: PokemonChainLink

    enum CodingKeys: String, CodingKey {
        case id
        case chain
    }
}
