//
//  InjectDependenciesProtocol.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//
import UIKit

protocol InjectDependenciesProtocol where Self: UIViewController {
    func initiate<T>(with dependencies: T...)
}
