//
//  CharacterInformationCoordinator.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class CharacterInformationCoordinator: Coordinator {
    private let character: Character

    init(presenter: Presentable?, character: Character) {
        self.character = character

        super.init(presenter: presenter)
    }

    override func start() {
        let viewModel = CharacterInformationViewModel(character: character, coordinator: self)
        let viewController = CharacterInformationViewController(viewModel: viewModel)
        show(viewController)
    }
}
