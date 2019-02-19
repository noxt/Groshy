//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let Actions.categoriesUpdated(categories: categories):
            return State(
                categories: categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: nil
            )

        case let Actions.sortOrderUpdated(sortOrder: sortOrder):
            return State(
                categories: old.categories,
                sortOrder: sortOrder,
                isLoading: false,
                error: nil
            )

        case Actions.loadingStarted:
            return State(
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: true,
                error: nil
            )

        case let Actions.error(message: message):
            return State(
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: message
            )

        default:
            return old

        }
    }
}
