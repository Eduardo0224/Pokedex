//
//  PokemonChainLink.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct PokemonChainLink: Codable {
    let species: NamedAPIResource
    let evolutionDetails: [PokemonEvolutionDetail]?
    let evolvesTo: [PokemonChainLink]?

    enum CodingKeys: String, CodingKey {
        case species
        case evolutionDetails = "evolution_detail"
        case evolvesTo = "evolves_to"
    }
}
