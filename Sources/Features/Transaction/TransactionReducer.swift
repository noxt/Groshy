//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let payload as AccountsFeature.Actions.CurrentAccountSelected:
            return State(
                accountID: payload.accountID,
                categoryID: old.categoryID,
                date: old.date,
                value: old.value
            )

        case let payload as Actions.CategorySelected:
            return State(
                accountID: old.accountID,
                categoryID: payload.categoryID,
                date: old.date,
                value: old.value
            )

        default:
            return old

        }
    }
}
