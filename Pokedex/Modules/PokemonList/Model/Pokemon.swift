//
//  Pokemon.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id, baseExperience, height, order, weight: Int
    let name, locationAreaEncounters: String
    let isDefault: Bool
    let types: [PokemonType]
    let sprites: PokemonSprites

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case order
        case weight

        case locationAreaEncounters = "location_area_encounters"
        case sprites
        case types
    }
}
