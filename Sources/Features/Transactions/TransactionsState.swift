//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension TransactionsFeature {
    struct State: Codable {

        let transactions: [Transaction.ID: Transaction]
        let isLoading: Bool
        let error: String?

        
        static let initial = State(
            transactions: [:],
            isLoading: false,
            error: nil
        )
    }
}
