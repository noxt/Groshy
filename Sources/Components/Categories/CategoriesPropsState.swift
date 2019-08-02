//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


enum CategoriesPropsState: Equatable {
    case loading
    case idle(categories: [CategoryInfo], addCategoryCommand: CommandOf<UIViewController>, editCategoryCommand: CommandOf<(UIViewController, Category.ID)>)
    case empty
}


extension CategoriesPropsState {
    struct CategoryInfo {
        let id: Category.ID
        let title: String
        let icon: UIImage
        let currentBalance: String?
        let selectCommand: Command?
        let isSelected: Bool
    }
}


// MARK: - Equatable

extension CategoriesPropsState.CategoryInfo: Equatable {
    static func ==(lhs: CategoriesPropsState.CategoryInfo, rhs: CategoriesPropsState.CategoryInfo) -> Bool {
        return lhs.id.rawValue.uuidString == rhs.id.rawValue.uuidString
            && lhs.title == rhs.title
            && lhs.icon.isEqual(rhs.icon)
            && lhs.currentBalance == rhs.currentBalance
            && lhs.selectCommand == rhs.selectCommand
            && lhs.isSelected == rhs.isSelected
    }
}
