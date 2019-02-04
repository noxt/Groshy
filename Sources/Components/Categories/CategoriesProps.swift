//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct CategoriesProps {

    struct CategoryInfo {
        let title: String
        let icon: UIImage
        let currentBalance: Double
        let selectCommand: PlainCommand?
    }

    enum State: Equatable {
        case loading
        case idle(categories: [CategoryInfo])
    }


    let state: State
    let loadCategoriesList: PlainCommand

}


// MARK: - Equatable

extension CategoriesProps.CategoryInfo: Equatable {
    static func ==(lhs: CategoriesProps.CategoryInfo, rhs: CategoriesProps.CategoryInfo) -> Bool {
        return lhs.title == rhs.title
            && lhs.icon == rhs.icon
            && lhs.currentBalance == rhs.currentBalance
            && (
                (lhs.selectCommand == nil && rhs.selectCommand == nil)
             || (lhs.selectCommand != nil && rhs.selectCommand != nil)
            )
    }
}

extension CategoriesProps: Equatable {
    static func ==(lhs: CategoriesProps, rhs: CategoriesProps) -> Bool {
        return lhs.state == rhs.state
    }
}

