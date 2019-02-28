//
//  Created by Dmitry Ivanenko on 28/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


protocol TransactionRepositoryProtocol {

    func loadTransactions() -> Promise<[Transaction]>
    func create(transaction: Transaction) -> Promise<Transaction>
    func update(transaction: Transaction) -> Promise<Transaction>
    func delete(transaction: Transaction) -> Promise<Void>

}
