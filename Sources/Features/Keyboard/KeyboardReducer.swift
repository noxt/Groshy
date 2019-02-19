//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension KeyboardFeature {
    static func reduce(_ old: State, with action: Action) -> State {
        switch action {

        case let Actions.currentValueUpdated(value: value):
            return State(
                expression: old.expression,
                currentValue: value
            )

        default:
            return old

        }
    }
}
