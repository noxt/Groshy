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
            onViewDidLoad: onViewDidLoad(),
            createAccountCommand: createAccountCommand()
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


    private func onViewDidLoad() -> PlainCommand {
        return PlainCommand {
            core.dispatch(AccountsFeature.Action.StartLoading())

            do {
                let accounts = try self.repositories.accountsRepository.loadAccounts()

                core.dispatch(AccountsFeature.Action.AccountsListLoaded(list: accounts))

                if let currentAccount = accounts.last {
                    core.dispatch(AccountsFeature.Action.SelectCurrentAccount(account: currentAccount))
                }
            } catch let e {
                core.dispatch(AccountsFeature.Action.Error(message: e.localizedDescription))
            }
        }
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
                let accounts = try self.repositories.accountsRepository.loadAccounts()
                core.dispatch(AccountsFeature.Action.AccountsListLoaded(list: accounts))
                core.dispatch(AccountsFeature.Action.SelectCurrentAccount(account: newAccount))
            } catch let e {
                core.dispatch(AccountsFeature.Action.Error(message: e.localizedDescription))
            }
        }
    }

}
