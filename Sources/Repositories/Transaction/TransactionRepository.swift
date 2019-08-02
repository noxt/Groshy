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

}


// MARK: - CRUD

extension TransactionRepository {

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


// MARK: - Filters

extension TransactionRepository {

    func filterTransactions(_ transactions: [Transaction.ID: Transaction], filter: TransactionFilter) -> [Transaction.ID: Transaction] {
        let granularity: Calendar.Component

        switch filter {
        case .perDay:
            granularity = .day
        case .perWeek:
            granularity = .weekOfYear
        case .perMonth:
            granularity = .month
        case .perYear:
            granularity = .year
        case .allTime:
            granularity = .era
        }

        return transactions.filter({ (_, transaction) -> Bool in
            Calendar.current.isDate(Date(), equalTo: transaction.date, toGranularity: granularity)
        })
    }

}


// MARK: - Grouping

extension TransactionRepository {

    func groupTransactionsByCategory(_ transactions: [Transaction.ID: Transaction]) -> [Category.ID: [Transaction]] {
        var groups = [Category.ID: [Transaction]]()

        for transaction in transactions.values {
            if groups[transaction.catagoryID] == nil {
                groups[transaction.catagoryID] = []
            }
            groups[transaction.catagoryID]?.append(transaction)
        }

        return groups
    }

    func groupTransactionsByAccount(from transactions: [Transaction.ID: Transaction]) -> [Account.ID: [Transaction]] {
        var groups = [Account.ID: [Transaction]]()

        for transaction in transactions.values {
            if groups[transaction.accountID] == nil {
                groups[transaction.accountID] = []
            }
            groups[transaction.accountID]?.append(transaction)
        }

        return groups
    }

}


// MARK: - Balance

extension TransactionRepository {

    func balanceForTransactions(_ transactions: [Transaction]) -> Double {
        return transactions.reduce(0, { (result, transaction) -> Double in
            result + transaction.value
        })
    }

}
