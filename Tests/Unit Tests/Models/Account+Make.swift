//
//  Created by Dmitry Ivanenko on 09/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
@testable import Groshy


extension Account {
    static func make(title: String) -> Account {
        return Account(
            id: Account.ID(rawValue: UUID()),
            title: title
        )
    }
}
