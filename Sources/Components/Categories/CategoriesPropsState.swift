//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


enum CategoriesPropsState: Equatable {
    case loading
    case idle(categories: [CategoryInfo])
    case empty
}


extension CategoriesPropsState {
    struct CategoryInfo {
        let id: Category.ID
        let title: String
        let icon: UIImage
        let currentBalance: String?
        let selectCommand: PlainCommand?
        
        var isSelected: Bool {
            return selectCommand == nil
        }
    }
}


// MARK: - Equatable

extension CategoriesPropsState.CategoryInfo: Equatable {
    static func ==(lhs: CategoriesPropsState.CategoryInfo, rhs: CategoriesPropsState.CategoryInfo) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.icon.isEqual(rhs.icon)
            && lhs.currentBalance == rhs.currentBalance
            && lhs.isSelected == rhs.isSelected
    }
}
