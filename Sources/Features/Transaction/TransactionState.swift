//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension TransactionFeature {

    struct State: Codable {

        let accountID: Account.ID?
        let categoryID: Category.ID?
        let date: Date?
        let value: Double?

        static let initial = State(
            accountID: nil,
            categoryID: nil,
            date: nil,
            value: nil
        )
    }

}
