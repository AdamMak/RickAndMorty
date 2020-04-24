//  
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine

final class CharactersViewModel: MappableViewModel {
    typealias CustomError = NetworkError

    @Published private(set) var cellViewModels: [CharactersTableCellViewModel] = []
    @Published private(set) var errors: Error?
    @Published private var pageCount = 1

    private var characters: [Character] = []
    private let service: CharactersListServiceProtocol
    private var totalPages = 0
    private var isRequestInProgress = false
    var cancellables = Set<AnyCancellable>()
    private let coordinator: CharactersCoordinator?

    private var shouldStartRequest: Bool {
        guard totalPages != 0 && isRequestInProgress == false else { return true }
        return pageCount <= totalPages
    }

    init(service: CharactersListServiceProtocol,
         coordinator: CharactersCoordinator?) {
        self.service = service
        self.coordinator = coordinator
    }

    deinit {
        cancellables.removeAll()
    }

    func getCharacter(for index: Int) -> Character {
        return characters[index]
    }

    func fetchCharacters() {
        guard shouldStartRequest else {
            return
        }

        let request = service.fetchCharacters(pageNumber: pageCount)
        let publisher = createPropertyPublisher(publisher: request)

        request.handleError(errorCompletion: { [weak self] error in
            self?.errors = error
        }).store(in: &cancellables)

        publisher.scan(pageCount, { previousValue, _ -> Int in
            previousValue + 1
        }).assign(to: \.pageCount, on: self)
            .store(in: &cancellables)

        let pages = publisher.mapErase { $0.info.pages }
        bind(pages, to: \.totalPages)

        addNewCharactersAndViewModels(publisher: publisher)

        let requestFinished = publisher.mapErase { _ in false }
        bind(requestFinished, to: \.isRequestInProgress)
    }

    private func addNewCharactersAndViewModels(publisher: AnyPublisher<CharacterInformation, Never>) {
        let newCharacters = publisher.mapErase { $0.results }
        newCharacters.scan(characters, { return $0 + $1 })
            .assign(to: \.characters, on: self)
            .store(in: &cancellables)

        let newCellViewModels = newCharacters.map {
            $0.map { CharactersTableCellViewModel(character: $0) }
        }
        newCellViewModels.scan(cellViewModels, { return $0 + $1 })
            .assign(to: \.cellViewModels, on: self)
            .store(in: &cancellables)
    }

    func didSelect(character: Character) {
        coordinator?.startInformationCoordinator(character: character)
    }
}
