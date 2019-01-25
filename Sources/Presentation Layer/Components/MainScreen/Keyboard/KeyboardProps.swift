//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct KeyboardProps {

    // Output
    let addDigit: Command<KeyboardFeature.Digit>
    let addOperation: Command<KeyboardFeature.Operation>
    let addComma: PlainCommand
    let removeLastSymbol: PlainCommand

}


// MARK: - Equatable

extension KeyboardProps: Equatable {

    static func == (lhs: KeyboardProps, rhs: KeyboardProps) -> Bool {
        return true
    }

}
