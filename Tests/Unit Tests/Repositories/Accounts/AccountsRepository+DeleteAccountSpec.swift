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
                    

                    it("updated in db") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .delete(account: account)
                                .done({ _ in
                                    expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                                    accounts.remove(at: 1)
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
                        services._securityStorageService.spyStorage[.accounts] = [
                            Account(id: UUID(), title: "Account #1"),
                            Account(id: UUID(), title: "Account #2"),
                            Account(id: UUID(), title: "Account #3"),
                        ]
                        account = Account(id: UUID(), title: "Some Account")
                    }

                    it("repository emit error") {
                        waitUntil(action: { (done) in
                            repositories.accountsRepository
                                .delete(account: account)
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
