//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct KeyboardProps {

    // Output
    let addDigitCommand: Command<KeyboardFeature.Digit>
    let addOperationCommand: Command<KeyboardFeature.Operation>
    let addCommaCommand: PlainCommand
    let removeLastSymbolCommand: PlainCommand
    let removeAllCommand: PlainCommand

}


// MARK: - Equatable

extension KeyboardProps: Equatable {

    static func == (lhs: KeyboardProps, rhs: KeyboardProps) -> Bool {
        return true
    }

}
