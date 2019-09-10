//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore
import Command


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        return MainScreenProps(
            currentBalance: currentBalance(for: state),
            currentValue: state.keyboardState.currentValue,
            currentFilter: state.transactionState.filter,
            hasHashtag: state.hashtagsState.selectedHashtag != nil,
            createTransactionCommand: createTransactionCommand(for: state),
            addHashtagCommand: addHashtagCommand()
        )
    }

}


// MARK: - Current balance

private extension MainScreenConnector {
    
    private func currentBalance(for state: AppFeature.State) -> String {
        var currentAccount: Account? = nil
        if let id = state.accountsState.currentAccountID {
            currentAccount = state.accountsState.accounts[id]
        }
        
        var currentBalance: Double = 0
        if let account = currentAccount {
            let filteredTransactions = repositories.transactionRepository.filterTransactions(state.transactionState.transactions, filter: state.transactionState.filter)
            let transactionsByAccount = repositories.transactionRepository.groupTransactionsByAccount(from: filteredTransactions)
            
            let transactions = transactionsByAccount[account.id] ?? []
            currentBalance = repositories.transactionRepository.balanceForTransactions(transactions)
        }
        
        return NumberFormatter.byn.string(from: NSNumber(value: currentBalance)) ?? ""
    }

}


// MARK: - Commands

private extension MainScreenConnector {

    func addHashtagCommand() -> CommandOf<UIViewController> {
        return CommandOf { [unowned self] vc in
            let component = AddHashtagScreenComponent.build(with: self.repositories)
            component.modalTransitionStyle = .crossDissolve
            vc.present(component, animated: true, completion: nil)
        }
    }
    
    func createTransactionCommand(for state: AppFeature.State) -> Command? {
        guard let accountID = state.accountsState.currentAccountID,
            let categoryID = state.categoriesState.selectedCategory,
            let value = NumberFormatter.currency.number(from: state.keyboardState.currentValue),
            value.doubleValue > 0 else {
                return nil
        }
        
        let transaction = Transaction(
            id: Transaction.ID(rawValue: UUID()),
            accountID: accountID,
            catagoryID: categoryID,
            hashtagID: state.hashtagsState.selectedHashtag,
            value: value.doubleValue,
            date: Date()
        )
        
        return TransactionsFeature.Commands.createTransaction(repositories).bound(to: transaction)
    }
    
}
