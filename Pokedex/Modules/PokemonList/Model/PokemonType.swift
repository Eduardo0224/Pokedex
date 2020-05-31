//
//  PokemonType.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

struct PokemonType: Codable {
    let slot: Int
    let type: Resource

    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }

    var image: UIImage? {
        TypeEnum(rawValue: self.type.name)?.image
    }
}

extension PokemonType {
    private enum TypeEnum: String {
        case bug, dark, dragon, electric, fairy, fight, fire, flying, ghost, grass, ground, ice, normal, poison, psychic, rock, steel, water, unknown

        var image: UIImage? {
            switch self {
                case .bug: return #imageLiteral(resourceName: "Bug.png")
                case .dark: return #imageLiteral(resourceName: "Dark.png")
                case .dragon: return #imageLiteral(resourceName: "Dragon.png")
                case .electric: return #imageLiteral(resourceName: "Electric.png")
                case .fairy: return #imageLiteral(resourceName: "Fairy.png")
                case .fight: return #imageLiteral(resourceName: "Fight.png")
                case .fire: return #imageLiteral(resourceName: "Fire.png")
                case .flying: return #imageLiteral(resourceName: "Flying.png")
                case .ghost: return #imageLiteral(resourceName: "Ghost.png")
                case .grass: return #imageLiteral(resourceName: "Grass.png")
                case .ground: return #imageLiteral(resourceName: "Ground.png")
                case .ice: return #imageLiteral(resourceName: "Ice.png")
                case .normal: return #imageLiteral(resourceName: "Normal.png")
                case .poison: return #imageLiteral(resourceName: "Poison.png")
                case .psychic: return #imageLiteral(resourceName: "Psychic.png")
                case .rock: return #imageLiteral(resourceName: "Rock.png")
                case .steel: return #imageLiteral(resourceName: "Steel.png")
                case .water: return #imageLiteral(resourceName: "Water.png")
                case .unknown: return nil
            }
        }
    }
}

