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

                    it("created in db") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .create(account: newAccount)
                                .done({ account in
                                    expect(account).to(equal(newAccount))
                                    expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                                    expect(services._securityStorageService.spySetValue as? [Account]).to(equal(accounts + [newAccount]))
                                    done()
                                })
                                .catch({ (error) in
                                    expect(error).to(beNil())
                                    done()
                                })
                        })
                    }
                }

                context("when storage emits error") {
                    var newAccount: Account!
                    beforeEach {
                        newAccount = Account(id: UUID(), title: "New Account")
                        services._securityStorageService.spyStorage[.accounts] = [Account]()
                        services._securityStorageService.spySetError = StorageServiceError.savingError
                    }

                    it("repository emit error") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .create(account: newAccount)
                                .done({ _ in
                                    expect(false).to(beFalse())
                                    done()
                                })
                                .catch({ (error) in
                                    expect(error.localizedDescription).to(equal(StorageServiceError.savingError.localizedDescription))
                                    done()
                                })
                        })
                    }
                }
            }
        }
    }
}
