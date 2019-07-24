//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


struct KeyboardProps {
    let addDigitCommand: CommandOf<KeyboardFeature.Digit>
    let addOperationCommand: CommandOf<KeyboardFeature.Operation>
    let addCommaCommand: Command
    let removeLastSymbolCommand: Command
    let removeAllCommand: Command
}


// MARK: - Equatable

extension KeyboardProps: Equatable {
    static func ==(lhs: KeyboardProps, rhs: KeyboardProps) -> Bool {
        return true
    }
}
