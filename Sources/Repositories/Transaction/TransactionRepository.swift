//
//  Created by Dmitry Ivanenko on 28/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


class TransactionRepository: TransactionRepositoryProtocol {

    private let storageService: StorageServiceProtocol


    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }

    func loadTransactions() -> Promise<[Transaction]> {
        return Promise { seal in
            do {
                seal.fulfill(try storageService.getValue(forKey: .transactions))
            } catch StorageServiceError.gettingError {
                try storageService.set(value: [Transaction](), forKey: .transactions)
                seal.fulfill([])
            }
        }
    }

    func create(transaction: Transaction) -> Promise<Transaction> {
        return loadTransactions()
            .then({ (transactions) -> Promise<[Transaction]> in
                return .value(transactions + [transaction])
            })
            .then({ [weak self] (transactions) -> Promise<Transaction> in
                try self?.storageService.set(value: transactions, forKey: .transactions)
                return .value(transaction)
            })
    }

    func update(transaction: Transaction) -> Promise<Transaction> {
        return loadTransactions()
            .then({ (transactions) -> Promise<[Transaction]> in
                guard let index = transactions.firstIndex(where: { $0.id == transaction.id }) else {
                    throw TransactionRepositoryError.transactionNotFound
                }

                var newTransactions = transactions
                newTransactions[index] = transaction
                return .value(newTransactions)
            })
            .then({ [weak self] (transactions) -> Promise<Transaction> in
                try self?.storageService.set(value: transactions, forKey: .transactions)
                return .value(transaction)
            })
    }

    func delete(transaction: Transaction) -> Promise<Void> {
        return loadTransactions()
            .then({ (transactions) -> Promise<[Transaction]> in
                guard let index = transactions.firstIndex(where: { $0.id == transaction.id }) else {
                    throw TransactionRepositoryError.transactionNotFound
                }

                var newTransactions = transactions
                newTransactions.remove(at: index)
                return .value(newTransactions)
            })
            .then({ [weak self] (transactions) -> Promise<Void> in
                try self?.storageService.set(value: transactions, forKey: .transactions)
                return Promise()
            })
    }
}
