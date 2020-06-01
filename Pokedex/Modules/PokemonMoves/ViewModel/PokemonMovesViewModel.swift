//
//  PokemonMovesViewModel.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

class PokemonMovesViewModel {
    // API Connection
    private let connection = PokemonMovesConnection()

    func getPokemonMove(with id: String, onComplete: @escaping (String) -> Void, onFailure: @escaping (PokedexAPI.NetworkError) -> Void) {
        let _ = connection.getPokemonMove(with: id) { result in
            switch result {
            case .success(let type):
                onComplete(type.type.name)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
