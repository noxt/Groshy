//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let payload as Actions.CategoriesUpdated:
            return State(
                categories: payload.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: nil
            )

        case is Actions.LoadingStarted:
            return State(
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: true,
                error: nil
            )

        case let payload as Actions.Error:
            return State(
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: payload.message
            )

        case let payload as Actions.SortOrderUpdated:
            return State(
                categories: old.categories,
                sortOrder: payload.sortOrder,
                isLoading: false,
                error: nil
            )

        default:
            return old

        }
    }
}
