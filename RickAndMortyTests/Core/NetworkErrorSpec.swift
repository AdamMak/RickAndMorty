//
//  NetworkErrorSpec.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 10/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Quick
import Nimble

@testable import RickAndMorty

class NetworkErrorSpec: QuickSpec {
    override func spec() {
        describe("error") {
            context("given status code of 401") {
                var error: NetworkError!

                beforeEach {
                    error = NetworkError.error(fromStatusCode: 401)
                }

                it("returns unauthorized") {
                    expect(error).to(equal(.unauthorized))
                }
            }

            context("given status code of 404") {
                var error: NetworkError!

                beforeEach {
                    error = NetworkError.error(fromStatusCode: 404)
                }

                it("returns notFound") {
                    expect(error).to(equal(.notFound))
                }
            }

            context("given an recognized status code") {
                var error: NetworkError!

                beforeEach {
                    error = NetworkError.error(fromStatusCode: 123)
                }

                it("returns 'otherError'") {
                    expect(error).to(equal(.otherError))
                }
            }
        }
    }
}
