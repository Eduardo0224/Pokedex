//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private var tagTypeImageViews: [UIImageView]!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentViewController: UIView!

    @IBOutlet private weak var abilitiesSegmentedControl: CustomSegmentedControl!

    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var statsViewController: PokemonStatsViewController?
    private var evolutionsViewController: PokemonEvolutionsViewController?
    private var movesViewController: PokemonMovesViewController?

    /// Current View Controller active and visible
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewControllers()
            updateActiveViewController()
        }
    }

    // ViewModel
    private let viewModel = PokemonDetailViewModel()
    private var pokemon: Pokemon?

    // MARK: - Functions
    private func removeInactiveViewControllers() {
        self.children.forEach {
            $0.didMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            addChild(activeVC)
            activeVC.view.frame = contentViewController.bounds
            contentViewController.addSubview(activeVC.view)
            activeVC.didMove(toParent: self)
        }
    }

    private func setupContainersViewControllers() {
        let evolutions = PokemonEvolutionsViewController.instantiateFromStoryboard(.pokemonEvolutions) as? PokemonEvolutionsViewController
        evolutions?.initiate(with: self.pokemon)
        evolutions?.delegate = self
        evolutionsViewController = evolutions

        statsViewController = PokemonStatsViewController.instantiateFromStoryboard(.pokemonStats)
        statsViewController?.delegate = self

        let moves = PokemonMovesViewController.instantiateFromStoryboard(.pokemonMoves) as? PokemonMovesViewController
        moves?.initiate(with: self.pokemon)
        moves?.delegate = self
        movesViewController = moves
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainersViewControllers()
        sendAction(of: .valueChanged, to: abilitiesSegmentedControl)
        guard let pokemon = pokemon else {
            return
        }
        setupDetails(with: pokemon)
    }

    private func setupDetails(with model: Pokemon) {
        avatarImageView.downloadAvatar(from: model.id)
        nameLabel.text = model.name.firstUppercased

        if model.types.count <= 3 {
            for (index, type) in model.types.enumerated() {
                tagTypeImageViews[index].isHidden = false
                tagTypeImageViews[index].image = type.tagImage
            }
        }

        abilitiesSegmentedControl.items = ["STATS", "EVOLUTIONS", "MOVES"]
        abilitiesSegmentedControl.font = UIFont(name: "Avenir-Medium", size: 13)
        abilitiesSegmentedControl.selectedIndex = 0
        abilitiesSegmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }

    @objc private func segmentedControlChanged(_ sender: CustomSegmentedControl) {
        switch sender.selectedIndex {
        case 0:
            activeViewController = statsViewController
        case 1:
            activeViewController = evolutionsViewController
        case 2:
            activeViewController = movesViewController

        default:
            break
        }
    }

}

extension PokemonDetailViewController: PokemonTableViewDelegate {
    func reloadDataDidUpdate(contentSizeHeight height: CGFloat) {
        contentViewHeightConstraint.constant = (height + 20)
    }


}

extension PokemonDetailViewController: InjectDependenciesProtocol {
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

