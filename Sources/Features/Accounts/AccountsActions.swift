//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension AccountsFeature {
    enum Actions: Action {
        case loadingStarted
        case currentAccountSelected(accountID: Account.ID)
        case accountsUpdated(accounts: [Account.ID: Account])
        case error(message: String)
    }
}
