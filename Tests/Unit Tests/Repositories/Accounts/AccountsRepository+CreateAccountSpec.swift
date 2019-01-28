//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Groshy


class AccountsRepository_CreateAccountSpec: QuickSpec {
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


            describe("create account") {
                context("when accounts list not empty") {
                    var newAccount: Account!
                    var accounts: [Account]!
                    beforeEach {
                        newAccount = Account(id: UUID(), title: "New Account")
                        accounts = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                        ]
                        services._securityStorageService.spyStorage[.accounts] = accounts
                    }

                    it("saved without errors") {
                        expect { try repositories.accountsRepository.create(account: newAccount) }.toNot(throwError())
                    }

                    it("setup key for accounts") {
                        try? repositories.accountsRepository.create(account: newAccount)
                        expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                    }

                    it("added in DB") {
                        try? repositories.accountsRepository.create(account: newAccount)
                        expect(services._securityStorageService.spySetValue as? [Account]).to(equal(accounts + [newAccount]))
                    }
                }

                context("when storage emits error") {
                    var newAccount: Account!
                    beforeEach {
                        newAccount = Account(id: UUID(), title: "New Account")
                        services._securityStorageService.spyStorage[.accounts] = [Account]()
                        services._securityStorageService.spySetError = StorageServiceError.savingError
                    }

                    it("emmit error") {
                        expect { try repositories.accountsRepository.create(account: newAccount) }.to(throwError(StorageServiceError.savingError))
                    }
                }
            }
        }
    }
}
