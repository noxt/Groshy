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
        describe("delete account") {
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
                it("should update db") {
                    var accounts = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                        Account.make(title: "Account #3"),
                    ]
                    services._securityStorageService.spyStorage[.accounts] = accounts
                    
                    let account = accounts[1]
                    
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

            context("storage emits an error") {
                it("should emit an error") {
                    services._securityStorageService.spyStorage[.accounts] = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                        Account.make(title: "Account #3"),
                    ]
                    let account = Account(id: Account.ID(rawValue: UUID()), title: "Some Account")
                    
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
