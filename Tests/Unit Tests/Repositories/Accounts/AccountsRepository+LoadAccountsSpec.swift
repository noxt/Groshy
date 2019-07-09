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
        describe("load accounts") {
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

            context("list not empty") {
                it("should return correct accounts") {
                    let accounts = [
                        Account.make(title: "Account #1"),
                        Account.make(title: "Account #2"),
                    ]
                    services._securityStorageService.spyStorage[.accounts] = accounts
                    
                    expect(repositories.accountsRepository.loadAccounts().value).to(equal(accounts))
                }
            }

            context("list is empty") {
                it("should return an empty accounts list") {
                    services._securityStorageService.spyStorage[.accounts] = [Account]()
                    
                    expect(repositories.accountsRepository.loadAccounts().value).to(equal([]))
                }
            }

            context("storage emits an error") {
                it("should return an empty accounts list") {
                    services._securityStorageService.spyGetError = StorageServiceError.gettingError
                    
                    expect(repositories.accountsRepository.loadAccounts().value).to(equal([]))
                }
            }
        }
    }
}
