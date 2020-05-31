//
//  PokemonEvolutionsConnection.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

class PokemonEvolutionsConnection {

    func getEvolutionsPokemon(with idOrName: String, completion: @escaping (ResultConnection<PokemonEvolutionChain>) -> Void) -> URLSessionTask? {
        guard let url = PokedexAPI.Endpoints.getEvolutions(idOrName.lowercased()).url else {
            completion(.failure(.urlNil))
            return nil
        }
        return PokedexAPI.taskForGETRequest(in: url, response: PokemonEvolutionChain.self, completion: completion)
    }
}
