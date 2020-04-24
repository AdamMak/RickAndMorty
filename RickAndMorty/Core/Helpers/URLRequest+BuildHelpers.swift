//
//  URLRequest+BuildHelpers.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 10/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

extension URLRequest {
    func addingBaseHeaders() -> URLRequest {
        var request = self
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    func addingMethod(method: HTTPMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
}
