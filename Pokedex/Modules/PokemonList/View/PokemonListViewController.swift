//
//  ViewController.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 29/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonListViewController: UITableViewController {

    // ViewModel
    private let viewModel = PokemonListViewModel()
    var searchController = UISearchController(searchResultsController: nil)
    private var currentSearchTask: URLSessionTask?
    private let activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupNavigationBar(withTitle: "Pokemon", and: searchController)
        registerPokemonTableViewCell()
        configureTableView()
        getPokemonList()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func registerPokemonTableViewCell() {
        tableView.register(cell: Constants.pokemonCell, withId: Constants.pokemonCellId)
    }

    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func getPokemonList() {
        show(indicator: activityIndicator, in: self)
        viewModel.getPokemonList(onComplete: {
            self.hide(indicator: self.activityIndicator, in: self)
            self.tableView.reloadData()
        }) { _ in
            self.hide(indicator: self.activityIndicator, in: self)
        }
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredPokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCellId, for: indexPath) as? PokemonTableViewCell
        cell?.configure(viewModel.filteredPokemons[indexPath.row])
        cell?.setNeedsLayout()
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? PokemonTableViewCell)?.configure(viewModel.filteredPokemons[indexPath.row])
        cell.setNeedsLayout()
    }
}

// MARK: - Constants
extension PokemonListViewController {
    struct Constants {
        static let pokemonCell = "PokemonTableViewCell"
        static let pokemonCellId = "PokemonCellId"
    }
}

// MARK: - UISearchBarDelegate
extension PokemonListViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.textField?.text, !text.isEmpty else {
            return
        }
        show(indicator: activityIndicator, in: self)
        currentSearchTask?.cancel()
        currentSearchTask = viewModel.getPokemon(by: searchBar.textField?.text ?? "", onComplete: {
            self.hide(indicator: self.activityIndicator, in: self)
            self.tableView.reloadData()
        }, onFailure: { error in
            self.hide(indicator: self.activityIndicator, in: self)
            self.alert(of: error) {
                searchBar.textField?.text = ""
                self.searchController.searchBar.becomeFirstResponder()
            }
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.textField?.text, !text.isEmpty else {
            if viewModel.filteredPokemons.count == 1 {
                reloadTableView()
            }
            endEditing(searchBar)
            return
        }
        reloadTableView()
        endEditing(searchBar)
    }

    private func reloadTableView() {
        viewModel.resetFilteredPokemonList()
        self.tableView.reloadData()
    }

    private func endEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}

