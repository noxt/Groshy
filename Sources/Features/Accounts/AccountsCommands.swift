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
                        core.dispatch(Actions.setAccounts(accounts))

                        if let currentAccount = accounts.last {
                            core.dispatch(Actions.selectAccount(currentAccount))
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
                        core.dispatch(Actions.setAccounts(accounts))
                        core.dispatch(Actions.selectAccount(newAccount))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        static func selectCurrentAccount(_ repositories: RepositoryProviderProtocol) -> Command<Account> {
            return Command<Account> { account in
                core.dispatch(Actions.selectAccount(account))
            }
        }

    }
}
