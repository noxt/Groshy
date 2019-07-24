//
//  Created by Dmitry Ivanenko on 27/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


struct MainScreenCommands {

    static func createTransactionCommand(_ repositories: RepositoryProviderProtocol, state: AppFeature.State) -> Command? {
        guard let accountID = state.accountsState.currentAccountID,
            let categoryID = state.categoriesState.selectedCategory,
            let value = NumberFormatter.currency.number(from: state.keyboardState.currentValue) else {
                return nil
        }
        
        guard value.doubleValue > 0 else {
            return nil
        }
        
        let transaction = Transaction(
            id: Transaction.ID(rawValue: UUID()),
            accountID: accountID,
            catagoryID: categoryID,
            value: value.doubleValue,
            date: Date()
        )
        
        return Command {
            TransactionsFeature.Commands.createTransaction(repositories).execute(with: transaction)
        }
    }

}
