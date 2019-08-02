//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    
    static func reduce(_ old: State, with action: Action) -> State {
        var state = old

        switch action {

        case let Actions.setCategories(categories):
            state.categories = normalize(categories: categories)
            state.sortOrder = categories.map({ $0.id })
            state.isLoading = false
            state.error = nil

        case let Actions.selectCategory(category):
            state.selectedCategory = category.id
            
        case Actions.clearSelectedCategory:
            state.selectedCategory = nil

        case Actions.loadingStarted:
            state.isLoading = true
            state.error = nil

        case let Actions.error(message: message):
            state.isLoading = false
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
    
    private static func normalize(categories: [Category]) -> [Category.ID: Category] {
        var dict: [Category.ID: Category] = [:]
        for category in categories {
            dict[category.id] = category
        }
        return dict
    }
    
}
