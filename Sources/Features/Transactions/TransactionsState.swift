//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension TransactionsFeature {
    struct State: Codable {

        var transactions: [Transaction.ID: Transaction]
        var filter: TransactionFilter
        var isLoading: Bool
        var error: String?

        
        static let initial = State(
            transactions: [:],
            filter: .perDay,
            isLoading: false,
            error: nil
        )
    }
}
