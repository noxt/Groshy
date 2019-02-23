//
//  Created by Dmitry Ivanenko on 23/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore
import PromiseKit


extension AccountsFeature {
    struct Commands {

        static func loadAccountsList(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.loadingStarted)

                repositories.accountsRepository.loadAccounts()
                    .done({ (accounts) in
                        core.dispatch(Actions.accountsUpdated(accounts: normalize(accounts: accounts)))

                        if let currentAccount = accounts.last {
                            core.dispatch(Actions.currentAccountSelected(accountID: currentAccount.id))
                        }
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        static func createAccount(_ repositories: RepositoryProviderProtocol) -> Command<Account> {
            return Command<Account> { newAccount in
                core.dispatch(Actions.loadingStarted)

                repositories.accountsRepository.create(account: newAccount)
                    .then({ (_) -> Promise<[Account]> in
                        return repositories.accountsRepository.loadAccounts()
                    })
                    .done({ (accounts) in
                        core.dispatch(Actions.accountsUpdated(accounts: normalize(accounts: accounts)))
                        core.dispatch(Actions.currentAccountSelected(accountID: newAccount.id))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        static func selectCurrentAccount(_ repositories: RepositoryProviderProtocol) -> Command<Account> {
            return Command<Account> { account in
                core.dispatch(Actions.currentAccountSelected(accountID: account.id))
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
