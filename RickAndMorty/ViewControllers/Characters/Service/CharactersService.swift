//
//  CharactersService.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine

class CharactersRequest: APIRequest {

    let method = HTTPMethod.get
    let url: URL
    var parameters: [String: String] = [:]

    init(pageNumber: Int) {
        self.url = URL(string: RequestURLs.charactersURL)!
        parameters["page"] = "\(pageNumber)"
    }
}

protocol CharactersListServiceProtocol {
    func fetchCharacters(pageNumber: Int) -> AnyPublisher<CharacterInformation, NetworkError>
}

class CharactersService: CharactersListServiceProtocol {
    private let manager: NetworkService

    init(manager: NetworkService = APIManager()) {
        self.manager = manager
    }

    func fetchCharacters(pageNumber: Int) -> AnyPublisher<CharacterInformation, NetworkError> {
        let request = CharactersRequest(pageNumber: pageNumber)
        return manager.makeRequest(apiRequest: request).eraseToAnyPublisher()
    }
}
