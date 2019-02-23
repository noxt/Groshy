//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Quick
import Nimble
import PromiseKit
@testable import Groshy


class AccountsRepository_LoadAccountsSpec: QuickSpec {
    override func spec() {
        describe("an accounts repository") {
            var repositories: RepositoryProviderProtocol!
            var services: MockServiceProvider!

            beforeEach {
                services = MockServiceProvider()
                repositories = RepositoryProvider(serviceProvider: services)
            }

            afterEach {
                repositories = nil
                services = nil
            }


            describe("load accounts") {
                context("when list not empty") {
                    var accounts: [Account] = []
                    beforeEach {
                        accounts = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                        ]

                        services._securityStorageService.spyStorage[.accounts] = accounts
                    }
                    it("returns correct accounts") {
                        expect(repositories.accountsRepository.loadAccounts().value).to(equal(accounts))
                    }
                }

                context("when list is empty") {
                    beforeEach {
                        services._securityStorageService.spyStorage[.accounts] = [Account]()
                    }
                    it("returns empty accounts list") {
                        expect(repositories.accountsRepository.loadAccounts().value).to(equal([]))
                    }
                }

                context("when storage emits error") {
                    beforeEach {
                        services._securityStorageService.spyGetError = StorageServiceError.gettingError
                    }
                    it("returns empty accounts list") {
                        expect(repositories.accountsRepository.loadAccounts().value).to(equal([]))
                    }
                }
            }
        }
    }
}
