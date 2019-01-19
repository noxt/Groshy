//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension AccountsFeature {

    struct State: Codable {

        let currentAccount: Account?
        let list: [Account]
        let isLoading: Bool
        let error: String?


        static let initial = State(
            currentAccount: nil,
            list: [],
            isLoading: false,
            error: nil
        )

    }

}
