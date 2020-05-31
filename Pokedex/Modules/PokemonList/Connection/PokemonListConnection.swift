//
//  PokemonListConnection.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonListConnection {

    private let limit = 150
    
    func getPokemonList(completion: @escaping (ResultConnection<APIResources>) -> Void) {
        guard let url = PokedexAPI.Endpoints.getPokemonList(limit).url else {
            completion(.failure(.urlNil))
            return
        }
        PokedexAPI.taskForGETRequest(in: url, response: APIResources.self, completion: completion)
    }

    func getPokemon(with idOrName: String, completion: @escaping (ResultConnection<Pokemon>) -> Void) -> URLSessionTask? {
        guard let url = PokedexAPI.Endpoints.getPokemon(idOrName.lowercased()).url else {
            completion(.failure(.urlNil))
            return nil
        }
        return PokedexAPI.taskForGETRequest(in: url, response: Pokemon.self, completion: completion)
    }
}
