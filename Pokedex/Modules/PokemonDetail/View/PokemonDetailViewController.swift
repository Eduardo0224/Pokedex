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
    @IBOutlet private weak var tagTypeImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var abilitiesSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
