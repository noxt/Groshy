//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let AccountsFeature.Actions.currentAccountSelected(accountID: accountID):
            return State(
                accountID: accountID,
                categoryID: old.categoryID,
                date: old.date,
                value: old.value,
                isLoading: false,
                error: nil
            )

        case let Actions.selectCategory(categoryID: categoryID):
            return State(
                accountID: old.accountID,
                categoryID: categoryID,
                date: old.date,
                value: old.value,
                isLoading: false,
                error: nil
            )

        case let Actions.selectDate(date):
            return State(
                accountID: old.accountID,
                categoryID: old.categoryID,
                date: date,
                value: old.value,
                isLoading: false,
                error: nil
            )

        case let Actions.renameValue(value):
            return State(
                accountID: old.accountID,
                categoryID: old.categoryID,
                date: old.date,
                value: value,
                isLoading: false,
                error: nil
            )

        case Actions.clear:
            return State.initial

        default:
            return old

        }
    }
}
