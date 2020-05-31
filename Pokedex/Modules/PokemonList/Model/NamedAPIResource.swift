//
//  NamedAPIResource.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//
typealias Resource = NamedAPIResource
struct NamedAPIResource: Codable {
    let name, url: String
}
