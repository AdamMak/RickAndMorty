//
//  Data+Helpers.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 10/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

extension Data {
    func decode<R : Decodable>(decodable : R.Type) throws -> R {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(decodable, from: self)
    }
}
