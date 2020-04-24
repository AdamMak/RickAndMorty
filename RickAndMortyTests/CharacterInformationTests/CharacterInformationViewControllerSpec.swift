//
//  CharacterInformationViewControllerSpec.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 28/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Combine
import Quick
import Nimble

@testable import RickAndMorty

class CharacterInformationViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Content") {
            var viewController: CharacterInformationViewController!
            var viewModel: CharacterInformationViewModel!

            beforeEach {
                let character = parseCharacterJSON()
                viewModel = CharacterInformationViewModel(character: character, coordinator: nil)
                viewController = CharacterInformationViewController(viewModel: viewModel)
                UIApplication.shared.windows.first?.rootViewController = viewController
            }

            context("on viewDidLoad") {
                it("sets up labels with expected text") {
                    expect(viewController.nameLabel.text).toEventually(equal(viewModel.name))
                    expect(viewController.statusLabel.text).toEventually(equal(viewModel.status))
                    expect(viewController.genderLabel.text).toEventually(equal(viewModel.gender))
                    expect(viewController.speciesLabel.text).toEventually(equal(viewModel.species))
                    expect(viewController.genderLabel.text).toEventually(equal(viewModel.gender))
                    expect(viewController.originLabel.text).toEventually(equal(viewModel.origin))
                }
            }
        }
    }
}
