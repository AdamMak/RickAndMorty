//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 10/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case dataNotExtracted
    case notFound
    case unauthorized
    case otherError

    static func error(fromStatusCode statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 404:
            return .notFound
        default:
            return .otherError
        }
    }
}
