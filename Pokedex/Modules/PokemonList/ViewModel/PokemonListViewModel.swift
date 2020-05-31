//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import Foundation

class PokemonListViewModel {
    // API Connection
    private let connection = PokemonListConnection()

    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()

    func resetFilteredPokemonList() {
        filteredPokemons = pokemons
    }

    func getPokemonList(onComplete: @escaping () -> Void,
                        onFailure: @escaping (PokedexAPI.NetworkError) -> Void) {
        connection.getPokemonList { [weak self] result in
            switch result {
            case .success(let apiResources):
                apiResources.results.forEach { (nameAPIResource) in
                    let id = nameAPIResource.url.split(separator: "/").last

                    let _ = self?.getPokemon(with: String(id ?? ""),
                                             onComplete: { pokemon in
                                                self?.pokemons.append(pokemon)
                                                self?.filteredPokemons.append(pokemon)
                                                self?.pokemons.sort { $0.id < $1.id }
                                                self?.filteredPokemons.sort { $0.id < $1.id }
                                                apiResources.results.count == self?.pokemons.count ? onComplete() : ()},
                                             onFailure: onFailure)
                }

            case .failure(let error):
                onFailure(error)
            }
        }
    }

    func getPokemon(by name: String, onComplete: @escaping () -> Void, onFailure: @escaping (PokedexAPI.NetworkError) -> Void) -> URLSessionTask? {
        return connection.getPokemon(with: name) { result in
            switch result {
            case .success(let pokemon):
                self.filteredPokemons.removeAll()
                self.filteredPokemons.append(pokemon)
                onComplete()
            case .failure(let error):
                self.resetFilteredPokemonList()
                onFailure(error)
            }
        }
    }

    func getPokemon(with id: String, onComplete: @escaping (Pokemon) -> Void, onFailure: @escaping (PokedexAPI.NetworkError) -> Void) {
        let _ = connection.getPokemon(with: id) { result in
            switch result {
            case .success(let pokemon):
                onComplete(pokemon)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
