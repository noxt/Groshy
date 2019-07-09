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
        describe("update account") {
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

            context("accounts list not empty") {
                it("should update record in db") {
                    var accounts = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                    ]
                    services._securityStorageService.spyStorage[.accounts] = accounts
                    
                    var account = accounts[1]
                    account.title = "New Account Title"
                    
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

            context("storage emits an error") {
                it("should emit an error") {
                    let account = Account.make(title: "New Account")
                    services._securityStorageService.spyStorage[.accounts] = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                        Account.make(title: "Account #3"),
                    ]
                    
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
