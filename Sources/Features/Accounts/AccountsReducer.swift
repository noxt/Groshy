//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let payload as Actions.CurrentAccountSelected:
            return State(
                currentAccountID: payload.accountID,
                accounts: old.accounts,
                isLoading: false,
                error: nil
            )

        case let payload as Actions.AccountsUpdated:
            return State(
                currentAccountID: old.currentAccountID,
                accounts: payload.accounts,
                isLoading: false,
                error: nil
            )

        case is Actions.LoadingStarted:
            return State(
                currentAccountID: old.currentAccountID,
                accounts: old.accounts,
                isLoading: true,
                error: nil
            )

        case let payload as Actions.Error:
            return State(
                currentAccountID: old.currentAccountID,
                accounts: old.accounts,
                isLoading: false,
                error: payload.message
            )

        default:
            return old

        }
    }
}
