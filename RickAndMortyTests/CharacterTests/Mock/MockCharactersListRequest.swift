//
//  MockCharactersListRequest.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 28/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine

@testable import RickAndMorty

class MockCharactersListRequest: CharactersListServiceProtocol {
    var isSuccessful: Bool

    init(isSuccessful: Bool) {
        self.isSuccessful = isSuccessful
    }

    func fetchCharacters(pageNumber: Int) -> AnyPublisher<CharacterInformation, NetworkError> {
        guard isSuccessful else {
            return Result<CharacterInformation, NetworkError>
                .Publisher(.failure(NetworkError.otherError))
                .eraseToAnyPublisher()
        }

        let fileURL = Bundle.main.url(forResource: "characters",
                                      withExtension: "json")
        let content = try! String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
        let data = content.data(using: .utf8)
        let dataModel = try! data!.decode(decodable: CharacterInformation.self)
        return Result<CharacterInformation, NetworkError>
            .Publisher(.success(dataModel))
            .eraseToAnyPublisher()
    }
}
