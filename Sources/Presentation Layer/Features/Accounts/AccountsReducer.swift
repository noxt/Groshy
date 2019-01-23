//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {

    static func reduce(_ old: State, with action: Unicore.Action) -> State {

        switch action {

        case let payload as Actions.SelectCurrentAccount:
            return State(
                currentAccount: payload.account,
                list: old.list,
                isLoading: false,
                error: nil
            )

        case let payload as Actions.AccountsListLoaded:
            return State(
                currentAccount: old.currentAccount,
                list: payload.list,
                isLoading: false,
                error: nil
            )

        case is Actions.StartLoading:
            return State(
                currentAccount: old.currentAccount,
                list: old.list,
                isLoading: true,
                error: nil
            )

        case let payload as Actions.Error:
            return State(
                currentAccount: old.currentAccount,
                list: old.list,
                isLoading: false,
                error: payload.message
            )

        default:
            return old

        }

    }

}
