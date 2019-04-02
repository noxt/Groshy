//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {
    enum Actions: Action {
        case loadingStarted
        case selectCategory(categoryID: Category.ID)
        case selectDate(Date)
        case renameValue(Double)
        case error(message: String)
        case clear
    }
}
