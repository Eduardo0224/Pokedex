//
//  PokemonMovesViewController.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

protocol PokemonTableViewDelegate {
    func reloadDataDidUpdate(contentSizeHeight height: CGFloat)
}

class PokemonMovesViewController: UITableViewController {

    private var pokemon: Pokemon?
    let viewModel = PokemonMovesViewModel()
    var delegate: PokemonTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        registerPokemonTableViewCell()
        tableView.reloadData()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        delegate?.reloadDataDidUpdate(contentSizeHeight: tableView.contentSize.height)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func registerPokemonTableViewCell() {
        tableView.register(cell: Constants.moveCell, withId: Constants.moveCellId)
    }

}

// MARK: - UITableViewDataSource
extension PokemonMovesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemon?.moves.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.moveCellId, for: indexPath) as? PokemonMoveTableViewCell
        if let pokemon = pokemon {
            let currentMove = pokemon.moves[indexPath.row].move
            let id = currentMove.url.split(separator: "/").last

            viewModel.getPokemonMove(with: String(id ?? ""), onComplete: { (move) in
                cell?.configure(currentMove.name, move: move)
                cell?.setNeedsLayout()
            }) { (_) in

            }



        }

        return cell ?? UITableViewCell()
    }


}

// MARK: - Constants
extension PokemonMovesViewController {
    struct Constants {
        static let moveCell = "PokemonMoveTableViewCell"
        static let moveCellId = "PokemonMoveCellId"
    }
}

extension PokemonMovesViewController: InjectDependenciesProtocol {
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
