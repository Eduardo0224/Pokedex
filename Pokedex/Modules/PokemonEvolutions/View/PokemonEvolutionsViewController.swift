//
//  PokemonEvolutionsViewController.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonEvolutionsViewController: UITableViewController {

    // ViewModel
    private let viewModel = PokemonEvolutionsViewModel()
    private(set) var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerEvolutionTableViewCell()

        guard let pokemon = pokemon else {
            return
        }
        viewModel.getPokemonEvolutions(by: String(pokemon.id), onComplete: {


        }) { (_) in

        }
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func registerEvolutionTableViewCell() {
        tableView.register(cell: Constants.evolutionCell, withId: Constants.evolutionCellId)
    }


}

// MARK: - UITableViewDataSource
extension PokemonEvolutionsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.evolutionCellId, for: indexPath) as? PokemonEvolutionTableViewCell
        cell?.setNeedsLayout()
        return cell ?? UITableViewCell()
    }
}

// MARK: - Constants
extension PokemonEvolutionsViewController {
    struct Constants {
        static let evolutionCell = "PokemonEvolutionTableViewCell"
        static let evolutionCellId = "PokemonEvolutionCellId"

    }
}

// MARK: - InjectDependenciesProtocol
extension PokemonEvolutionsViewController: InjectDependenciesProtocol {
    func initiate<T>(with dependencies: T...) {
        dependencies.forEach { (dependency) in
            switch dependency {
            case let pokemon as Pokemon:
                self.pokemon = pokemon
            default:
                break
            }
        }
    }
}
