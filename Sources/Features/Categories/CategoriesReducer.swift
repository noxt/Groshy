//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let Actions.setCategories(categories):
            return State(
                selectedCategory: old.selectedCategory,
                categories: normalize(categories: categories),
                sortOrder: categories.map({ $0.id }),
                isLoading: false,
                error: nil
            )

        case let Actions.selectCategory(category):
            return State(
                selectedCategory: category.id,
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: nil
            )
            
        case Actions.clearSelectedCategory:
            return State(
                selectedCategory: nil,
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: nil
            )

        case Actions.loadingStarted:
            return State(
                selectedCategory: old.selectedCategory,
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: true,
                error: nil
            )

        case let Actions.error(message: message):
            return State(
                selectedCategory: old.selectedCategory,
                categories: old.categories,
                sortOrder: old.sortOrder,
                isLoading: false,
                error: message
            )
            
        case let Actions.moveCategory(categoryID, toPosition: position):
            var sortOrder = old.sortOrder
            if let oldPosition = sortOrder.firstIndex(of: categoryID) {
                let info = sortOrder.remove(at: oldPosition)
                sortOrder.insert(info, at: position)
            }
            
            return State(
                selectedCategory: old.selectedCategory,
                categories: old.categories,
                sortOrder: sortOrder,
                isLoading: old.isLoading,
                error: old.error
            )

        default:
            return old

        }
    }
    
    private static func normalize(categories: [Category]) -> [Category.ID: Category] {
        var dict: [Category.ID: Category] = [:]
        for category in categories {
            dict[category.id] = category
        }
        return dict
    }
    
}
