//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit
import Unicore


extension TransactionsFeature {

    struct Commands {
        
        static func loadTransactionsList(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.loadingStarted)
                
                repositories.transactionRepository.loadTransactions()
                    .done({ (transactions) in
                        core.dispatch(Actions.setTransactions(transactions))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        static func createTransaction(_ repositories: RepositoryProviderProtocol) -> Command<Transaction> {
            return Command<Transaction> { transaction in
                core.dispatch(Actions.loadingStarted)
                
                repositories.transactionRepository.create(transaction: transaction)
                    .then({ (_) -> Promise<[Transaction]> in
                        return repositories.transactionRepository.loadTransactions()
                    })
                    .done({ (transactions) in
                        core.dispatch(Actions.setTransactions(transactions))
                        core.dispatch(KeyboardFeature.Actions.currentValueUpdated(value: ""))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

    }

}
