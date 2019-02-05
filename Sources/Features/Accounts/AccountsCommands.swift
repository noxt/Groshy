//
//  Created by Dmitry Ivanenko on 23/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    struct Commands {

        static func loadAccountsList(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.LoadingStarted())

                do {
                    let accounts = try repositories.accountsRepository.loadAccounts()
                    core.dispatch(Actions.AccountsUpdated(accounts: normalize(accounts: accounts)))

                    if let currentAccount = accounts.last {
                        core.dispatch(Actions.CurrentAccountSelected(accountID: currentAccount.id))
                    }
                } catch let e {
                    core.dispatch(Actions.Error(message: e.localizedDescription))
                }
            }
        }

        static func createAccount(_ repositories: RepositoryProviderProtocol) -> Command<Account> {
            return Command<Account> { newAccount in
                core.dispatch(Actions.LoadingStarted())

                do {
                    try repositories.accountsRepository.create(account: newAccount)
                    let accounts = try repositories.accountsRepository.loadAccounts()
                    core.dispatch(Actions.AccountsUpdated(accounts: normalize(accounts: accounts)))
                    core.dispatch(Actions.CurrentAccountSelected(accountID: newAccount.id))
                } catch let e {
                    core.dispatch(Actions.Error(message: e.localizedDescription))
                }
            }
        }

        static func selectCurrentAccount(_ repositories: RepositoryProviderProtocol) -> Command<Account> {
            return Command<Account> { account in
                core.dispatch(Actions.CurrentAccountSelected(accountID: account.id))
            }
        }

        private static func normalize(accounts: [Account]) -> [Account.ID: Account] {
            var dict: [Account.ID: Account] = [:]
            for account in accounts {
                dict[account.id] = account
            }
            return dict
        }

    }
}
