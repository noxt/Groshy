//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    
    static func reduce(_ old: State, with action: Action) -> State {
        var state = old
        state.isLoading = false
        state.error = nil

        switch action {

        case let Actions.setCategories(categories):
            state.categories = categories.normalized
            state.sortOrder = categories.map({ $0.id })

        case let Actions.selectCategory(category):
            state.selectedCategory = category.id
            
        case Actions.clearSelectedCategory:
            state.selectedCategory = nil

        case Actions.loadingStarted:
            state.isLoading = true

        case let Actions.error(message: message):
            state.error = message
            
        case let Actions.moveCategory(categoryID, toPosition: position):
            var sortOrder = old.sortOrder
            if let oldPosition = sortOrder.firstIndex(of: categoryID) {
                let info = sortOrder.remove(at: oldPosition)
                sortOrder.insert(info, at: position)
            }

            state.sortOrder = sortOrder

        default:
            break

        }

        return state
    }
    
}
