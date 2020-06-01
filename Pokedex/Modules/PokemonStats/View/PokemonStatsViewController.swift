//
//  PokemonStatsViewController.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonStatsViewController: UIViewController {

    var delegate: PokemonTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.reloadDataDidUpdate(contentSizeHeight: 600)
    }
    



}
