//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionsFeature {

    static func reduce(_ old: State, with action: Action) -> State {
        var state = old
        state.isLoading = false
        state.error = nil
        
        switch action {
        case let Actions.setTransactions(transactions):
            state.transactions = transactions.normalized
            
        case let Actions.setFilter(filter):
            state.filter = filter

        case Actions.loadingStarted:
            state.isLoading = true
            
        case let Actions.error(message: message):
            state.error = message

        default:
            break
        }
        
        return state
    }

}
