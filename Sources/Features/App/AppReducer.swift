//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AppFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        return State(
            accountsState: AccountsFeature.reduce(old.accountsState, with: action),
            categoriesState: CategoriesFeature.reduce(old.categoriesState, with: action),
            keyboardState: KeyboardFeature.reduce(old.keyboardState, with: action),
            transactionState: TransactionsFeature.reduce(old.transactionState, with: action),
            hashtagsState: HashtagsFeature.reduce(old.hashtagsState, with: action)
        )
    }
}
