//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


class AccountsRepository: AccountsRepositoryProtocol {

    private let storageService: StorageServiceProtocol


    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }


    func loadAccounts() -> Promise<[Account]> {
        return Promise { seal in
            do {
                seal.fulfill(try storageService.getValue(forKey: .accounts))
            } catch StorageServiceError.gettingError {
                try storageService.set(value: [Account](), forKey: .accounts)
                seal.fulfill([])
            }
        }
    }

    func create(account: Account) -> Promise<Account> {
        return loadAccounts()
            .then({ (accounts) -> Promise<[Account]> in
                return .value(accounts + [account])
            })
            .then({ [weak self] (accounts) -> Promise<Account> in
                try self?.storageService.set(value: accounts, forKey: .accounts)
                return .value(account)
            })
    }

    func update(account: Account) -> Promise<Account> {
        return loadAccounts()
            .then({ (accounts) -> Promise<[Account]> in
                guard let index = accounts.firstIndex(where: { $0.id == account.id }) else {
                    throw AccountsRepositoryError.accountNotFound
                }

                var newAccounts = accounts
                newAccounts[index] = account
                return .value(newAccounts)
            })
            .then({ [weak self] (accounts) -> Promise<Account> in
                try self?.storageService.set(value: accounts, forKey: .accounts)
                return .value(account)
            })
    }

    func delete(account: Account) -> Promise<Void> {
        return loadAccounts()
            .then({ (accounts) -> Promise<[Account]> in
                guard let index = accounts.firstIndex(where: { $0.id == account.id }) else {
                    throw AccountsRepositoryError.accountNotFound
                }

                var newAccounts = accounts
                newAccounts.remove(at: index)
                return .value(newAccounts)
            })
            .then({ [weak self] (accounts) -> Promise<Void> in
                try self?.storageService.set(value: accounts, forKey: .accounts)
                return Promise()
            })
    }

}
