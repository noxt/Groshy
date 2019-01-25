//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AppFeature {

    static func reduce(_ old: State, with action: Unicore.Action) -> State {
        return State(
            accountsState: AccountsFeature.reduce(old.accountsState, with: action),
            keyboardState: KeyboardFeature.reduce(old.keyboardState, with: action)
        )
    }

}
