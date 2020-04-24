//
//  CharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class CharactersCoordinator: Coordinator {
    override func start() {
        let service = CharactersService()
        let viewModel = CharactersViewModel(service: service, coordinator: self)
        let viewController = CharactersViewController(viewModel: viewModel)
        show(viewController)
    }

    func startInformationCoordinator(character: Character) {
        let coordinator = CharacterInformationCoordinator(presenter: presenter, character: character)
        coordinator.start()
    }
}
