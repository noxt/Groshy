//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {

    struct Actions {

        struct CurrentCategorySelected: Action {
            let categoryID: Category.ID
        }

        struct LoadingStarted: Action {

        }

        struct CategoriesUpdated: Action {
            let categories: [Category.ID: Category]
        }

        struct SortOrderUpdated: Action {
            let sortOrder: [Category.ID]
        }

        struct Error: Action {
            let message: String
        }

    }

}

