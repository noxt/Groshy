//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Groshy


class AccountsRepository_DeleteAccountSpec: QuickSpec {
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


            describe("delete account") {
                context("when accounts list not empty") {
                    var account: Account!
                    var accounts: [Account]!
                    beforeEach {
                        accounts = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                            Account(id: UUID(), title: "Account #3"),
                        ]
                        services._securityStorageService.spyStorage[.accounts] = accounts

                        account = accounts[1]
                    }

                    it("deleted without errors") {
                        expect { try repositories.accountsRepository.delete(account: account) }.toNot(throwError())
                    }

                    it("setup key for accounts") {
                        try? repositories.accountsRepository.delete(account: account)
                        expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                    }

                    it("updated in DB") {
                        try? repositories.accountsRepository.delete(account: account)
                        accounts.remove(at: 1)
                        expect(services._securityStorageService.spySetValue as? [Account]).to(equal(accounts))
                    }
                }

                context("when storage emits error") {
                    var account: Account!
                    beforeEach {
                        services._securityStorageService.spyStorage[.accounts] = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                            Account(id: UUID(), title: "Account #3"),
                        ]
                        account = Account(id: UUID(), title: "Some Account")
                    }

                    it("emmit error") {
                        expect { try repositories.accountsRepository.delete(account: account) }.to(throwError(AccountsRepositoryError.accountNotFound))
                    }
                }
            }
        }
    }
}
