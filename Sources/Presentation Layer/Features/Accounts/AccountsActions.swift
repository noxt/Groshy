//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    
    struct Actions {

        struct CurrentAccountSelected: Action {
            let accountID: Account.ID
        }

        struct LoadingStarted: Action {

        }

        struct AccountsLoaded: Action {
            let accounts: [Account]
        }

        struct Error: Action {
            let message: String
        }

    }

}
