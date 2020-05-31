//
//  InjectDependenciesProtocol.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

protocol InjectDependenciesProtocol {
    func initiate<T>(with dependencies: T...)
}
