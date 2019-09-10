//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation

extension AccountsFeature {
    struct State: Codable {

        var currentAccountID: Account.ID?
        var accounts: [Account.ID : Account]
        var isLoading: Bool
        var error: String?


        static let initial = State(
            currentAccountID: nil,
            accounts: [:],
            isLoading: false,
            error: nil
        )

    }
}
