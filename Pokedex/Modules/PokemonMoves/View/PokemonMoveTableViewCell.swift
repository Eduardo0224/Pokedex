//
//  PokemonMoveTableViewCell.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 31/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonMoveTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var levelLabel: UILabel!
    @IBOutlet private weak var typeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ name: String, move: String) {
        nameLabel.text = name.firstUppercased

        // TODO: Hacer request a al endpoitn de movimientos
        typeImageView.isHidden = false
        typeImageView.image = PokemonType.TypeEnum(rawValue: move)?.image
    }    
}
