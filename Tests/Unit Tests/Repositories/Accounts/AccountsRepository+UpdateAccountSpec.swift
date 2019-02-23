//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Groshy


class AccountsRepository_UpdateAccountSpec: QuickSpec {
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

            describe("update account") {
                context("when accounts list not empty") {
                    var account: Account!
                    var accounts: [Account]!
                    beforeEach {
                        accounts = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                        ]
                        services._securityStorageService.spyStorage[.accounts] = accounts

                        account = accounts[1]
                        account.title = "New Account Title"
                    }

                    it("updated in db") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .update(account: account)
                                .done({ _ in
                                    expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                                    accounts[1] = account
                                    expect(services._securityStorageService.spySetValue as? [Account]).to(equal(accounts))
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
                    var account: Account!
                    beforeEach {
                        account = Account(id: UUID(), title: "New Account")
                        services._securityStorageService.spyStorage[.accounts] = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                            Account(id: UUID(), title: "Account #3"),
                        ]
                    }

                    it("repository emit error") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .update(account: account)
                                .done({ _ in
                                    expect(false).to(beFalse())
                                    done()
                                })
                                .catch({ (error) in
                                    expect(error.localizedDescription).to(equal(AccountsRepositoryError.accountNotFound.localizedDescription))
                                    done()
                                })
                        })
                    }
                }
            }
        }
    }
}
