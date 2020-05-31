//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Eduardo Andrade on 30/05/20.
//  Copyright © 2020 Eduardo Andrade. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private var typesImageViews: [UIImageView]!

    // MARK: - Functions
    func configure(_ model: Pokemon) {
        nameLabel.text = model.name.firstUppercased
        idLabel.text = "#00\(model.id)"
        downloadAvatarImage(with: model.id)

        guard model.types.count <= 3 else { return }
        for (index, type) in model.types.enumerated() {
            typesImageViews[index].image = type.image
        }
    }

    private func downloadAvatarImage(with id: Int) {
        avatarImageView.donwloadAvatar(from: id)
    }
}
