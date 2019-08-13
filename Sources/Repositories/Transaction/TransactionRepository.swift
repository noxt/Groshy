//
//  Created by Dmitry Ivanenko on 28/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class TransactionRepository: TransactionRepositoryProtocol {

    private let crudRepository: CRUDRepository<Transaction>


    init(crudRepository: CRUDRepository<Transaction>) {
        self.crudRepository = crudRepository
    }

}


// MARK: - CRUD

extension TransactionRepository {

    func loadTransactions() -> Promise<[Transaction]> {
        return crudRepository.loadItems()
    }

    func create(transaction: Transaction) -> Promise<[Transaction]> {
        return crudRepository.create(transaction)
    }

    func update(transaction: Transaction) -> Promise<[Transaction]> {
        return crudRepository.update(transaction)
    }

    func delete(transactionId: Transaction.ID) -> Promise<[Transaction]> {
        return crudRepository.delete(transactionId)
    }
    
    func deleteTransactions(forCategoryId categoryId: Category.ID) -> Promise<[Transaction]> {
        return crudRepository.delete(where: { (transaction) -> Bool in
            return transaction.catagoryID == categoryId
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
