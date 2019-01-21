//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
@testable import Groshy


class AccountsRepositoryTests: BaseUnitTests {

//    func create(account: Account) throws
//    func update(account: Account) throws
//    func delete(account: Account) throws

    func test__LoadAccounts__Success() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
        ]

        services._securityStorageService.spyStorage[.accounts] = accounts

        XCTAssertNoThrow(try repositories.accountsRepository.loadAccounts())
        XCTAssertEqual(try! repositories.accountsRepository.loadAccounts(), accounts)
    }

    func test__LoadAccounts__Empty() {
        let accounts: [Account] = []

        services._securityStorageService.spyStorage[.accounts] = accounts

        XCTAssertNoThrow(try repositories.accountsRepository.loadAccounts())
        XCTAssertEqual(try! repositories.accountsRepository.loadAccounts(), accounts)
    }

    func test__LoadAccounts__NotFound() {
        services._securityStorageService.spyGetError = StorageServiceError.gettingError

        XCTAssertNoThrow(try repositories.accountsRepository.loadAccounts())
        XCTAssertEqual(try! repositories.accountsRepository.loadAccounts(), [])
    }

    func test__CreateAccount__Success() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
        ]
        let newAccount = Account(id: UUID(), title: "New Account")

        services._securityStorageService.spyStorage[.accounts] = accounts

        XCTAssertNoThrow(try repositories.accountsRepository.create(account: newAccount))

        XCTAssertEqual(services._securityStorageService.spySetKey, .accounts)
        XCTAssertEqual(services._securityStorageService.spySetValue as! [Account], accounts + [newAccount])
    }

}
