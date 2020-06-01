//
//  PokemonMovesConnection.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

class PokemonMovesConnection {

    func getPokemonMove(with idOrName: String, completion: @escaping (ResultConnection<PokemonMoveModel>) -> Void) -> URLSessionTask? {
        guard let url = PokedexAPI.Endpoints.getMoves(idOrName.lowercased()).url else {
            completion(.failure(.urlNil))
            return nil
        }
        return PokedexAPI.taskForGETRequest(in: url, response: PokemonMoveModel.self, completion: completion)
    }
}
