//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class AccountSelectorConnector: BaseConnector<AccountSelectorProps> {

    override func mapToProps(state: AppFeature.State) -> AccountSelectorProps {
        return AccountSelectorProps(
            state: mapToPropsState(state: state),
            loadAccountsList: AccountsFeature.Commands.loadAccountsList(repositories)
        )
    }

    private func mapToPropsState(state: AppFeature.State) -> AccountSelectorProps.State {
        let accountsState = state.accountsState

        guard !accountsState.isLoading else {
            return .loading
        }

        var currentAccount: Account? = nil
        if let id = accountsState.currentAccountID {
            currentAccount = accountsState.accounts[id]
        }

        return .idle(
            title: currentAccount?.title ?? "Undefined account",
            amount: "1 953 BYN"
        )
    }

}
