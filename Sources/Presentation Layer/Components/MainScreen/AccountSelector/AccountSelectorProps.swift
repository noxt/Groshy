//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct AccountSelectorProps {

    enum State: Equatable {
        case idle(title: String, amount: String)
        case loading
    }


    // Input
    let state: State

    // Output
    let loadAccountsList: PlainCommand

}


// MARK: - Equatable

extension AccountSelectorProps: Equatable {
    static func ==(lhs: AccountSelectorProps, rhs: AccountSelectorProps) -> Bool {
        return lhs.state == rhs.state
    }
}
