//
//  APIResources.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

struct APIResources: Codable {
    let count: Int
    let next: String
    let previous: Bool?
    let results: [NamedAPIResource]
}
