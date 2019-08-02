//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        let balance = currentBalance(state)
        return MainScreenProps(
            currentBalance: NumberFormatter.byn.string(from: NSNumber(value: balance)) ?? "",
            currentValue: state.keyboardState.currentValue,
            createTransactionCommand: MainScreenCommands.createTransactionCommand(repositories, state: state)
        )
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
