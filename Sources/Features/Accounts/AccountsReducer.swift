//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let Actions.currentAccountSelected(accountID: accountID):
            return State(
                currentAccountID: accountID,
                accounts: old.accounts,
                isLoading: false,
                error: nil
            )

        case let Actions.accountsUpdated(accounts: accounts):
            return State(
                currentAccountID: old.currentAccountID,
                accounts: accounts,
                isLoading: false,
                error: nil
            )

        case Actions.loadingStarted:
            return State(
                currentAccountID: old.currentAccountID,
                accounts: old.accounts,
                isLoading: true,
                error: nil
            )

        case let Actions.error(message: message):
            return State(
                currentAccountID: old.currentAccountID,
                accounts: old.accounts,
                isLoading: false,
                error: message
            )

        default:
            return old

        }
    }
}
