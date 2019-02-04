//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class AccountsRepository: AccountsRepositoryProtocol {

    private let storageService: StorageServiceProtocol


    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }


    func loadAccounts() throws -> [Account] {
        let accounts: [Account]

        do {
            accounts = try storageService.getValue(forKey: .accounts)
        } catch StorageServiceError.gettingError {
            accounts = []
            try storageService.set(value: accounts, forKey: .accounts)
        }

        return accounts
    }

    func create(account: Account) throws {
        var accounts = try loadAccounts()
        accounts.append(account)
        try storageService.set(value: accounts, forKey: .accounts)
    }

    func update(account: Account) throws {
        var accounts = try loadAccounts()

        guard let index = accounts.firstIndex(where: { $0.id == account.id }) else {
            throw AccountsRepositoryError.accountNotFound
        }

        accounts[index] = account

        try storageService.set(value: accounts, forKey: .accounts)
    }

    func delete(account: Account) throws {
        var accounts = try loadAccounts()

        guard let index = accounts.firstIndex(where: { $0.id == account.id }) else {
            throw AccountsRepositoryError.accountNotFound
        }

        accounts.remove(at: index)

        try storageService.set(value: accounts, forKey: .accounts)
    }

}
