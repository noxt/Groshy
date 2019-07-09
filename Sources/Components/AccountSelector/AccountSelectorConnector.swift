//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class AccountSelectorConnector: BaseConnector<AccountSelectorPropsState> {

    override func mapToProps(state: AppFeature.State) -> AccountSelectorPropsState {
        return mapToPropsState(state: state)
    }

    private func mapToPropsState(state: AppFeature.State) -> AccountSelectorPropsState {
        let accountsState = state.accountsState

        guard !accountsState.isLoading else {
            return .loading
        }

        var currentAccount: Account? = nil
        if let id = accountsState.currentAccountID {
            currentAccount = accountsState.accounts[id]
        }
        
        var currentBalance: Double = 0
        if let account = currentAccount {
            let transactions = self.transactions(from: state.transactionState, for: account)
            currentBalance = transactions.reduce(0, { (result, transaction) -> Double in
                return result + transaction.value
            })
        }
        
        return .idle(
            title: currentAccount?.title ?? "Undefined account",
            amount: NumberFormatter.byn.string(from: NSNumber(value: currentBalance)) ?? ""
        )
    }
    
    private func transactions(from state: TransactionsFeature.State, for account: Account) -> [Transaction] {
        return state.transactions.values.filter({ (transaction) -> Bool in
            transaction.accountID == account.id
        })
    }

}
