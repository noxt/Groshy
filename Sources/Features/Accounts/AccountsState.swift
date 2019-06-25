//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation

extension AccountsFeature {
    struct State: Codable {

        let currentAccountID: Account.ID?
        let accounts: [Account.ID : Account]
        let isLoading: Bool
        let error: String?


        static let initial = State(
            currentAccountID: nil,
            accounts: [:],
            isLoading: false,
            error: nil
        )

    }
}
