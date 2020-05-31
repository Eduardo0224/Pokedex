//
//  PokemonEvolutionsViewModel.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

class PokemonEvolutionsViewModel {

    // API Connection
    private let connection = PokemonEvolutionsConnection()

    var evolutions = [EvolutionModel]()

    func getPokemonEvolutions(by id: String, onComplete: @escaping () -> Void, onFailure: @escaping (PokedexAPI.NetworkError) -> Void) {

        let _ = connection.getEvolutionsPokemon(with: id) { result in
            switch result {

            case .success(_):
                onComplete()
                break
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
