//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class AccountSelectorConnector: BaseConnector<AccountSelectorProps> {

    override func mapToProps(state: AppFeature.State) -> AccountSelectorProps {
        let accountsState = state.accountsState

        let state: AccountSelectorProps.State
        if accountsState.isLoading {
            state = .loading
        } else {
            var currentAccount: Account? = nil

            if let id = accountsState.currentAccountID {
                currentAccount = accountsState.accounts[id]
            }

            state = .idle(
                title: currentAccount?.title ?? "",
                amount: "1 953 BYN"
            )
        }

        return AccountSelectorProps(
            // Input
            state: state,

            // Output
            loadAccountsList: AccountsFeature.Commands.loadAccountsList(repositories)
        )
    }

}
