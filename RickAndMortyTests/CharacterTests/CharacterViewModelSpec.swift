
//
//  CharacterInformationViewModelSpec.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 27/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
import Quick
import Nimble

@testable import RickAndMorty

class SpyCharactersCoordinator: CharactersCoordinator {
    private(set) var didCallStartInformation = false

    override func startInformationCoordinator(character: Character) {
        didCallStartInformation = true
    }
}

class CharacterViewModelSpec: QuickSpec {
    override func spec() {
        describe("fetchCharacters") {
            var viewModel: CharactersViewModel!

            context("given fetch characters is successful") {
                var spy: SpyCharactersCoordinator!
                let expectedCount = 4

                beforeEach {
                    spy = SpyCharactersCoordinator(presenter: nil)
                    let service = MockCharactersListRequest(isSuccessful: true)
                    viewModel = CharactersViewModel(service: service, coordinator: spy)
                    viewModel.fetchCharacters()
                }

                it("returns the expected number of cellViewModels") {
                    expect(viewModel.cellViewModels.count).toEventually(equal(expectedCount))
                }

                it("returns no error") {
                    expect(viewModel.errors).to(beNil())
                }

                context("when getCharacter is called") {
                    var character: Character!

                    beforeEach {
                        character = viewModel.getCharacter(for: 0)
                    }

                    it("returns a valid character") {
                        expect(character).toEventuallyNot(beNil())
                    }

                    context("when didSelect is called") {
                        beforeEach {
                            viewModel.didSelect(character: character)
                        }

                        it("sends message 'startInformationCoordinator' to coordinator ") {
                            expect(spy.didCallStartInformation).to(beTrue())
                        }
                    }
                }
            }

            context("given fetch characters request fails") {
                beforeEach {
                    let service = MockCharactersListRequest(isSuccessful: false)
                    viewModel = CharactersViewModel(service: service, coordinator: nil)
                    viewModel.fetchCharacters()
                }

                context("when cellViewModels is called") {
                    it("returns 0") {
                        expect(viewModel.cellViewModels.count).toEventually(equal(0))
                    }

                    it("returns an error") {
                        expect(viewModel.errors).toEventuallyNot(beNil())
                    }
                }
            }
        }
    }
}
