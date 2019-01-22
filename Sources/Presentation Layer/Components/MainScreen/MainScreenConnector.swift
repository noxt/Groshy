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

            // Output
            createAccountCommand: createAccountCommand()
        )
    }

    private func currentAccountTitle(_ account: Account?) -> String {
        guard let account = account else {
            return "Add new account"
        }

        return "[\(account.id)]\n\(account.title)"
    }

    private func createAccountCommand() -> PlainCommand {
        return PlainCommand {
            let newAccount = Account(
                id: UUID(),
                title: "New Account"
            )

            core.dispatch(AccountsFeature.Action.StartLoading())

            do {
                try self.repositories.accountsRepository.create(account: newAccount)
                core.dispatch(AccountsFeature.Action.SelectCurrentAccount(account: newAccount))
            } catch let e {
                core.dispatch(AccountsFeature.Action.Error(message: e.localizedDescription))
            }
        }
    }

}
