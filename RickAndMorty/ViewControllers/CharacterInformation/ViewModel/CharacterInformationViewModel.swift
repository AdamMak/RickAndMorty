//  
//  CharacterInformationViewModel.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class CharacterInformationViewModel {
    private let character: Character
    private let coordinator: CharacterInformationCoordinator?

    init(character: Character,
         coordinator: CharacterInformationCoordinator?) {
        self.character = character
        self.coordinator = coordinator
    }

    var name: String {
        return character.name
    }

    var id: String {
        return "id: \(character.id)"
    }

    var status: String {
        return character.status
    }

    var species: String {
        return character.species
    }

    var gender: String {
        return character.gender
    }

    var origin: String {
        return character.origin.name
    }

    var location: String {
        return character.location.name
    }

    var imageURL: String {
        return character.image
    }
}
