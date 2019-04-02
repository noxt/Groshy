//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {

    struct Commands {

        static func clear() -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.clear)
            }
        }

        static func selectCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { category in
                core.dispatch(Actions.selectCategory(categoryID: category.id))
            }
        }

        static func selectDate() -> Command<Date> {
            return Command<Date> { date in
                core.dispatch(Actions.selectDate(date))
            }
        }

        static func updateValue() -> Command<Double> {
            return Command<Double> { value in
                core.dispatch(Actions.renameValue(value))
            }
        }

        static func createTransaction(_ repositories: RepositoryProviderProtocol, state: State) -> PlainCommand {
            return PlainCommand {
                guard let accountID = state.accountID,
                    let categoryID = state.categoryID,
                    let value = state.value else {
                    return
                }

                let transaction = Transaction(
                    id: Transaction.ID(),
                    accountID: accountID,
                    catagoryID: categoryID,
                    value: value,
                    date: state.date ?? Date()
                )

                repositories.transactionRepository.create(transaction: transaction)
                    .done({ (transaction) in
                        core.dispatch(Actions.loadingStarted)
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

    }

}
