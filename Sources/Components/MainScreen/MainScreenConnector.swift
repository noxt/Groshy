//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        return MainScreenProps(
            currentValue: state.keyboardState.currentValue,
            isNewTransactionValid: isNewTransactionValid(state: state),
            addCategoryCommand: MainScreenCommands.addCategoryCommand(repositories),
            createTransactionCommand: createTransactionCommand(state: state)
        )
    }
    
    private func createTransactionCommand(state: AppFeature.State) -> PlainCommand {
        return PlainCommand { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let accountID = state.accountsState.currentAccountID,
                let categoryID = state.categoriesState.selectedCategory,
                let value = Double(state.keyboardState.currentValue) else {
                    return
            }
            
            let transaction = Transaction(
                id: Transaction.ID(rawValue: UUID()),
                accountID: accountID,
                catagoryID: categoryID,
                value: value,
                date: Date()
            )
            
            TransactionsFeature.Commands.createTransaction(self.repositories).execute(with: transaction)
        }
    }
    
    private func isNewTransactionValid(state: AppFeature.State) -> Bool {
        return state.accountsState.currentAccountID != nil &&
            state.categoriesState.selectedCategory != nil &&
            Double(state.keyboardState.currentValue) != nil
    }

}
