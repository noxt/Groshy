//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    
    struct Action {

        struct SelectCurrentAccount: Unicore.Action {
            let account: Account
        }

        struct StartLoading: Unicore.Action {

        }

        struct AccountsListLoaded: Unicore.Action {
            let list: [Account]
        }

        struct Error: Unicore.Action {
            let message: String
        }

    }

}
