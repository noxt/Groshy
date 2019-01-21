//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
@testable import Groshy


class AccountsRepositoryTests: BaseUnitTests {

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

    func test__CreateAccount__Failure() {
        let newAccount = Account(id: UUID(), title: "New Account")

        services._securityStorageService.spyStorage[.accounts] = [Account]()

        services._securityStorageService.spySetError = StorageServiceError.savingError

        XCTAssertThrowsError(try repositories.accountsRepository.create(account: newAccount)) { (error) in
            XCTAssertEqual(error.localizedDescription, StorageServiceError.savingError.localizedDescription)
        }
    }

    func test__UpdateAccount__Sussess() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
            Account(id: UUID(), title: "Account #3"),
        ]
        services._securityStorageService.spyStorage[.accounts] = accounts

        var account: Account = accounts[1]
        account.title = "New Account Title"

        XCTAssertNoThrow(try repositories.accountsRepository.update(account: account))

        let newAccounts = try? repositories.accountsRepository.loadAccounts()
        XCTAssertEqual(newAccounts?.first(where: { $0.id == account.id })?.title, account.title)
    }

    func test__UpdateAccount__NotFound() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
            Account(id: UUID(), title: "Account #3"),
        ]
        services._securityStorageService.spyStorage[.accounts] = accounts

        let newAccount = Account(id: UUID(), title: "New Account")

        XCTAssertThrowsError(try repositories.accountsRepository.update(account: newAccount)) { (error) in
            XCTAssertEqual(error.localizedDescription, AccountsRepositoryError.accountNotFound.localizedDescription)
        }
    }

    func test__DeleteAccount__Sussess() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
            Account(id: UUID(), title: "Account #3"),
            ]
        services._securityStorageService.spyStorage[.accounts] = accounts

        XCTAssertNoThrow(try repositories.accountsRepository.delete(account: accounts[1]))

        let newAccounts = try? repositories.accountsRepository.loadAccounts()
        XCTAssertEqual(newAccounts?.count, 2)
        XCTAssertNil(newAccounts?.first(where: { $0.id == accounts[1].id }))
    }

    func test__DeleteAccount__NotFound() {
        let accounts = [
            Account(id: UUID(), title: "Account #1"),
            Account(id: UUID(), title: "Account #2"),
            Account(id: UUID(), title: "Account #3"),
            ]
        services._securityStorageService.spyStorage[.accounts] = accounts

        let newAccount = Account(id: UUID(), title: "Some Account")

        XCTAssertThrowsError(try repositories.accountsRepository.delete(account: newAccount)) { (error) in
            XCTAssertEqual(error.localizedDescription, AccountsRepositoryError.accountNotFound.localizedDescription)
        }
    }

}
