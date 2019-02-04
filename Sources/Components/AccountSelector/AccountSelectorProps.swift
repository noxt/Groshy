//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct AccountSelectorProps {

    struct AccountInfo: Equatable {
        let title: String
        let amount: String
    }

    enum State: Equatable {
        case idle(info: AccountInfo)
        case loading
    }


    let state: State
    let loadAccountsList: PlainCommand

}


// MARK: - Equatable

extension AccountSelectorProps: Equatable {
    static func ==(lhs: AccountSelectorProps, rhs: AccountSelectorProps) -> Bool {
        return lhs.state == rhs.state
    }
}
