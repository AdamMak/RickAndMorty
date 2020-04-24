//
//  CharactersTableCellViewModel.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class CharactersTableCellViewModel {
    private let character: Character

    var name: String {
        return character.name
    }

    var imageURL: String {
        return character.image
    }

    init(character: Character) {
        self.character = character
    }
}

extension CharactersTableCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(character.id)
    }

    // MARK: Equatable

    static func == (lhs: CharactersTableCellViewModel, rhs: CharactersTableCellViewModel) -> Bool {
        return lhs.character.id == rhs.character.id
    }
}
