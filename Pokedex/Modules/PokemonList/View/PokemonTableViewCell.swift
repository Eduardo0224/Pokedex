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
    override func awakeFromNib() {
        super.awakeFromNib()
        changeSelectedColor()
    }

    func configure(_ model: Pokemon) {
        nameLabel.text = model.name.firstUppercased
        idLabel.text = "#00\(model.id)"
        downloadAvatarImage(from: model.sprites.frontDefault ?? "")

        guard model.types.count <= 3 else { return }
        for (index, type) in model.types.enumerated() {
            typesImageViews[index].isHidden = false
            typesImageViews[index].image = type.image
        }
    }

    private func downloadAvatarImage(from urlString: String) {
        avatarImageView.downloadImage(from: urlString)
    }

    private func changeSelectedColor() {
        let colorView = UIView()
        colorView.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.6196078431, blue: 0.8745098039, alpha: 1)
        selectedBackgroundView = colorView
    }
}
