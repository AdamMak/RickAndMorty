//
//  CharactersViewControllerSpec.swift
//  RickAndMortyTests
//
//  Created by Adam Makhfoudi on 28/04/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import RickAndMorty

class CharactersViewControllerSpec: QuickSpec {
    override func spec() {
        describe("given fetch characters is successful") {
            var viewController: CharactersViewController!
            var spy: SpyCharactersCoordinator!

            beforeEach {
                let service = MockCharactersListRequest(isSuccessful: true)
                spy = SpyCharactersCoordinator(presenter: nil)
                let viewModel = CharactersViewModel(service: service, coordinator: spy)
                viewController = CharactersViewController(viewModel: viewModel)
                UIApplication.shared.windows.first?.rootViewController = viewController
            }

            context("on viewDidLoad") {
                let expectedCount = 4

                it("shows tableView with expected number of cells") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(expectedCount))
                }
            }

            context("when cell is tapped") {
                beforeEach {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))

                    let indexPath = IndexPath(row: 0, section: 0)
                    viewController.tableView.delegate?.tableView?(viewController.tableView!, didSelectRowAt: indexPath)
                }

                it("sends a 'didSelect' message to its delegate") {
                    expect(spy.didCallStartInformation).toEventually(beTrue())
                }
            }
        }

        describe("given fetch character request fails") {
            var viewController: CharactersViewController!
            var service: MockCharactersListRequest!

            beforeEach {
                service = MockCharactersListRequest(isSuccessful: false)
                let viewModel = CharactersViewModel(service: service, coordinator: nil)
                viewController = CharactersViewController(viewModel: viewModel)
                UIApplication.shared.windows.first?.rootViewController = viewController
            }

            context("when tableView is loaded") {
                it("has 0 cells") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(0))
                }
            }

            context("alert") {
                beforeEach {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(0))
                }

                it("shows an alert") {
                    let alertController = viewController.presentedViewController as? UIAlertController
                    expect(alertController).toEventuallyNot(beNil())
                }

                context("when try again is tapped") {
                    context("and request is successful") {
                        beforeEach {
                            service.isSuccessful = true

                            let alertController = viewController.presentedViewController as? UIAlertController
                            alertController?.tapButton(atIndex: 0)
                        }

                        it("tableView reloads with 4 cells") {
                            expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(4))
                        }
                    }

                    context("and request fails again") {
                        beforeEach {
                            service.isSuccessful = false

                            let alertController = viewController.presentedViewController as? UIAlertController
                            alertController?.tapButton(atIndex: 0)
                        }

                        it("tableView will still have 0 cells") {
                            expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(0))
                        }
                    }
                }
            }
        }
    }
}

extension UIAlertController {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    func tapButton(atIndex index: Int) {
        guard let block = actions[index].value(forKey: "handler") else { return }
        let handler = unsafeBitCast(block as AnyObject, to: AlertHandler.self)
        handler(actions[index])
    }
}
