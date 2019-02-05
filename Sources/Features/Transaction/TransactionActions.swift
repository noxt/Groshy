//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {

    struct Actions {

        struct CategorySelected: Action {
            let categoryID: Category.ID
        }

    }

}

