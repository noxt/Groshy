//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionsFeature {

    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let Actions.setTransactions(transactions):
            return State(
                transactions: normalize(transactions: transactions),
                isLoading: false,
                error: nil
            )
            
        case Actions.loadingStarted:
            return State(
                transactions: old.transactions,
                isLoading: true,
                error: nil
            )
            
        case let Actions.error(message: message):
            return State(
                transactions: old.transactions,
                isLoading: false,
                error: message
            )

        default:
            return old

        }
    }
    
    private static func normalize(transactions: [Transaction]) -> [Transaction.ID: Transaction] {
        var dict: [Transaction.ID: Transaction] = [:]
        for transaction in transactions {
            dict[transaction.id] = transaction
        }
        return dict
    }

}
