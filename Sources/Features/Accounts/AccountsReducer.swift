//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {

    static func reduce(_ old: State, with action: Action) -> State {
        var state = old
        state.isLoading = false
        state.error = nil

        switch action {
        case let Actions.selectAccount(account):
            state.currentAccountID = account.id

        case let Actions.setAccounts(accounts):
            state.accounts = accounts.normalized

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
