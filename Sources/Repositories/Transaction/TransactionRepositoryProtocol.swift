//
//  Created by Dmitry Ivanenko on 28/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


protocol TransactionRepositoryProtocol {

    // CRUD
    func loadTransactions() -> Promise<[Transaction]>
    func create(transaction: Transaction) -> Promise<Transaction>
    func update(transaction: Transaction) -> Promise<Transaction>
    func delete(transaction: Transaction) -> Promise<Void>
    func deleteTransactions(forCategoryId categoryId: Category.ID) -> Promise<Void>

    // Filters
    func filterTransactions(_ transactions: [Transaction.ID: Transaction], filter: TransactionFilter) -> [Transaction.ID: Transaction]
    
    // Grouping
    func groupTransactionsByCategory(_ transactions: [Transaction.ID: Transaction]) -> [Category.ID: [Transaction]]
    func groupTransactionsByAccount(from transactions: [Transaction.ID: Transaction]) -> [Account.ID: [Transaction]]
    
    // Balance
    func balanceForTransactions(_ transactions: [Transaction]) -> Double

}
