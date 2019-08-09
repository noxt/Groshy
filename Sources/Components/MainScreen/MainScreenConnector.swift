//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore
import Command


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        let balance = currentBalance(state)
        return MainScreenProps(
            currentBalance: NumberFormatter.byn.string(from: NSNumber(value: balance)) ?? "",
            currentValue: state.keyboardState.currentValue,
            currentFilter: state.transactionState.filter,
            hasHashtag: state.hashtagsState.selectedHashtag != nil,
            createTransactionCommand: MainScreenCommands.createTransactionCommand(repositories, state: state),
            addHashtagCommand: addHashtagCommand()
        )
    }
    
    private func addHashtagCommand() -> CommandOf<UIViewController> {
        return CommandOf { [unowned self] vc in
            let component = AddHashtagScreenComponent.build(with: self.repositories)
            component.modalTransitionStyle = .crossDissolve
            vc.present(component, animated: true, completion: nil)
        }
    }

    private func currentBalance(_ state: AppFeature.State) -> Double {
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

        return currentBalance
    }

}
