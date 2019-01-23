//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        let accountState = state.accountsState

        return MainScreenProps(
            // Input
            currentAccountTitle: currentAccountTitle(accountState.currentAccount),
            counterTitle: counterTitle(accountState.list.count),

            // Output
            loadAccountsListCommand: AccountsFeature.Commands.loadAccountsList(repositories),
            createAccountCommand: AccountsFeature.Commands.createAccount(repositories)
        )
    }

    private func currentAccountTitle(_ account: Account?) -> String {
        guard let account = account else {
            return "Add new account"
        }

        return "[\(account.id)]\n\(account.title)"
    }

    private func counterTitle(_ count: Int) -> String {
        return "Accounts in DB: \(count)"
    }

}
