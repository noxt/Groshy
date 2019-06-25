//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    enum Actions: Action {
        case loadingStarted
        case setCategories([Category])
        case selectCategory(Category)
        case clearSelectedCategory
        case error(message: String)
    }
}
