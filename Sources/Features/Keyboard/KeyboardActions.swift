//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension KeyboardFeature {
    struct Actions {

        struct CurrentValueUpdated: Action {
            let value: String
        }

    }
}
