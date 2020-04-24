//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine
import Foundation

class APIManager {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = URLSession.shared) {
        self.session = session
        self.decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

extension APIManager: NetworkService {
    func makeRequest<ResponseType: APIResponse>(apiRequest: APIRequest) -> AnyPublisher<ResponseType, NetworkError> {
        return session
            .dataTaskPublisher(for: apiRequest.urlRequest())
            .validateResponse()
            .decode(type: ResponseType.self, decoder: decoder)
            .mapError { $0 as? NetworkError ?? NetworkError.dataNotExtracted }
            .eraseToAnyPublisher()
    }
}

// When we have a publisher whose output is from the URLSession dataTaskPublisher, we can validateResponse().
// This maps any URLErrors to our custom NetworkError, and extracts the Data from the Output.
private extension Publisher where Output == URLSession.DataTaskPublisher.Output, Failure == URLError {
    func validateResponse() -> AnyPublisher<Data, NetworkError> {

        return self
            .mapError { NetworkError.error(fromStatusCode: $0.code.rawValue) }
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw NetworkError.otherError
                }

                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.error(fromStatusCode: httpResponse.statusCode)
                }

                return element.data
            }
            .mapError { $0 as? NetworkError ?? NetworkError.otherError }
            .eraseToAnyPublisher()
    }
}
