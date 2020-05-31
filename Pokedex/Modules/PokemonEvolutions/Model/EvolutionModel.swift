//
//  EvolutionModel.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation


struct EvolutionModel {
    let pokemons: [PokemonModel]
    let level: Int
}

struct PokemonModel {
    let name, imageURL: String
}
