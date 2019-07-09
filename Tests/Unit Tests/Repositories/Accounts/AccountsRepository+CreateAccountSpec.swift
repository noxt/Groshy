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
        describe("create account") {
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
            
            context("accounts list is empty") {
                it("should create new record in storage") {
                    let newAccount = Account.make(title: "New Account")
                    services._securityStorageService.spyStorage[.accounts] = [Account]()
                    
                    waitUntil(action: { (done) in
                        repositories.accountsRepository
                            .create(account: newAccount)
                            .done({ account in
                                expect(account).to(equal(newAccount))
                                expect(services._securityStorageService.spySetKey).to(equal(.accounts))
                                expect(services._securityStorageService.spySetValue as? [Account]).to(equal([newAccount]))
                                done()
                            })
                            .catch({ (error) in
                                expect(error).to(beNil())
                                done()
                            })
                    })
                }
            }

            context("accounts list is not empty") {
                it("should add account in storage") {
                    let newAccount = Account.make(title: "New Account")
                    let accounts = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                    ]
                    services._securityStorageService.spyStorage[.accounts] = accounts
                    
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

            context("storage emits an error") {
                it("should emit an error") {
                    let newAccount = Account.make(title: "New Account")
                    services._securityStorageService.spyStorage[.accounts] = [Account]()
                    services._securityStorageService.spySetError = StorageServiceError.savingError
                    
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
