//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


extension KeyboardFeature {
    struct Commands {

        static func addDigit(currentValue: String) -> CommandOf<Digit> {
            return CommandOf<Digit> { digit in
                var newValue = currentValue

                if newValue == "0" {
                    newValue = String(digit)
                } else {
                    newValue.append(String(digit))
                }

                core.dispatch(Actions.currentValueUpdated(value: newValue))
            }
        }

        static func addOperation(currentValue: String) -> CommandOf<Operation> {
            return CommandOf<Operation> { digit in

            }
        }

        static func addComma(currentValue: String) -> Command {
            return Command {
                guard let commaCharacter = NumberFormatter().decimalSeparator,
                    currentValue.firstIndex(of: commaCharacter.first!) == nil else {
                    return
                }

                var newValue = currentValue
                if newValue.isEmpty {
                    newValue.append("0")
                }
                newValue.append(commaCharacter)
                core.dispatch(Actions.currentValueUpdated(value: newValue))
            }
        }

        static func removeLastSymbol(currentValue: String) -> Command {
            return Command {
                guard !currentValue.isEmpty else {
                    return
                }

                var newValue = currentValue
                newValue.removeLast()

                if newValue.isEmpty {
                    newValue = "0"
                }

                core.dispatch(Actions.currentValueUpdated(value: newValue))
            }
        }

        static func removeAllCommand() -> Command {
            return Command {
                core.dispatch(Actions.currentValueUpdated(value: "0"))
            }
        }

    }
}
