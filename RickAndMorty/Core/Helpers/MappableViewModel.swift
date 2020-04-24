//
//  MappableViewModel.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 19/06/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

typealias SubscriberResponse<CustomError: Swift.Error> = Subscribers.Completion<CustomError>

typealias CompletionHandler<CustomError: Swift.Error> = (SubscriberResponse<CustomError>) -> Void

protocol MappableViewModel: class {
    associatedtype CustomError: Swift.Error
    var cancellables: Set<AnyCancellable> { get set }

    func bind<Value>(_ publisher: AnyPublisher<Value, Never>,
                             to keyPath: ReferenceWritableKeyPath<Self, Value>)
    func createPropertyPublisher<Value>(publisher: AnyPublisher<Value, CustomError>) -> AnyPublisher<Value, Never>
}

extension MappableViewModel {
    func bind<Value>(_ publisher: AnyPublisher<Value, Never>,
                             to keyPath: ReferenceWritableKeyPath<Self, Value>) {
        publisher
            .assign(to: keyPath, on: self)
            .store(in: &cancellables)
    }

    func createPropertyPublisher<Value>(publisher: AnyPublisher<Value, CustomError>) -> AnyPublisher<Value, Never> {
        return publisher
            .catch { _ in Empty<Value, Never>() }
            .eraseToAnyPublisher()
    }
}
