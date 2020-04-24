//
//  CharactersTableViewCell.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell, NibLoader {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var characterImageView: UIImageView!

    func configure(with viewModel: CharactersTableCellViewModel) {
        nameLabel.text = viewModel.name
        nameLabel.textColor = .white
        characterImageView.cacheImage(urlString: viewModel.imageURL)
        characterImageView.layer.cornerRadius = 10
    }
}
