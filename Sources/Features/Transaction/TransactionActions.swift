//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {
    enum Actions: Action {
        case categorySelected(categoryID: Category.ID)
    }
}
