//
//  APIRequest.swift
//  RickAndMorty
//
//  Created by Adam Makhfoudi on 24/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

typealias APIResponse = Decodable

protocol APIRequest {
    var method: HTTPMethod { get }
    var url: URL { get }
    var parameters: [String: String] { get }

    func urlRequest() -> URLRequest
}

extension APIRequest {
    func urlRequest() -> URLRequest {
        return buildRequestFromParams()
            .addingMethod(method: method)
            .addingBaseHeaders()
    }

    fileprivate func buildRequestFromParams() -> URLRequest {
        switch method {
        case .get:
            return buildGetRequestFromParams()
        case .post:
            return buildPostPatchRequestFromParams()
        }
    }

    private func buildGetRequestFromParams() -> URLRequest {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters
            .map { URLQueryItem(name: $0, value: $1) }
            .sorted(by: { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending })

        guard let resultUrl = components?.url else {
            return URLRequest(url: url)
        }

        return URLRequest(url: resultUrl)
    }

    private func buildPostPatchRequestFromParams() -> URLRequest {
        var request = URLRequest(url: url)
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        return request
    }
}
