//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension AppFeature {
    struct State: Codable {

        let accountsState: AccountsFeature.State
        let categoriesState: CategoriesFeature.State
        let keyboardState: KeyboardFeature.State
        let transactionState: TransactionFeature.State


        static let initial = State(
            accountsState: .initial,
            categoriesState: .initial,
            keyboardState: .initial,
            transactionState: .initial
        )

    }
}
