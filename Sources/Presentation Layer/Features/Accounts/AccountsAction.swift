//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    
    struct Action {

        struct CreateAccount: Unicore.Action {
            let account: Account
        }

        struct EditAccount: Unicore.Action {
            let account: Account
        }

        struct DeleteAccount: Unicore.Action {
            let account: Account
        }

        struct UpdateAccount: Unicore.Action {
            let account: Account
            let list: [Account]
        }

        struct StartLoading: Unicore.Action {

        }

        struct Failure: Unicore.Action {
            let error: String
        }

    }

}
