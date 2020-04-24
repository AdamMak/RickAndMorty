//
//  CharacterInformationViewModelSpec.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 28/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
import Quick
import Nimble

@testable import RickAndMorty

class CharacterInformationViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: CharacterInformationViewModel!
        
        beforeEach {
            let character = parseCharacterJSON()
            viewModel = CharacterInformationViewModel(character: character, coordinator: nil)
        }

        describe("name") {
            let expectedName = "Rick Sanchez"

            it("returns expected name") {
                expect(viewModel.name).toEventually(equal(expectedName))
            }
        }

        describe("id") {
            let expectedId = "id: 1"

            it("returns expected id") {
                expect(viewModel.id).toEventually(equal(expectedId))
            }
        }

        describe("status") {
            let expectedStatus = "Alive"

            it("returns expected id") {
                expect(viewModel.status).toEventually(equal(expectedStatus))
            }
        }

        describe("species") {
            let expectedSpecies = "Human"

            it("returns expected id") {
                expect(viewModel.species).toEventually(equal(expectedSpecies))
            }
        }

        describe("gender") {
            let expectedGender = "Male"

            it("returns expected gender") {
                expect(viewModel.gender).toEventually(equal(expectedGender))
            }
        }

        describe("origin") {
            let expectedOrigin = "Earth (C-137)"

            it("returns expected origin") {
                expect(viewModel.origin).toEventually(equal(expectedOrigin))
            }
        }

        describe("Location") {
            let expectedLocation = "Earth (Replacement Dimension)"

            it("returns expected location") {
                expect(viewModel.location).toEventually(equal(expectedLocation))
            }
        }
    }
}
