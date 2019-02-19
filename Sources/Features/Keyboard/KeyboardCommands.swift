//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension KeyboardFeature {
    struct Commands {

        static func addDigit(currentValue: String) -> Command<Digit> {
            return Command<Digit> { digit in
                var newValue = currentValue

                if newValue == "0" {
                    newValue = String(digit)
                } else {
                    newValue.append(String(digit))
                }

                core.dispatch(Actions.currentValueUpdated(value: newValue))
            }
        }

        static func addOperation(currentValue: String) -> Command<Operation> {
            return Command<Operation> { digit in

            }
        }

        static func addComma(currentValue: String) -> PlainCommand {
            return PlainCommand {
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

        static func removeLastSymbol(currentValue: String) -> PlainCommand {
            return PlainCommand {
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

        static func removeAllCommand() -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.currentValueUpdated(value: "0"))
            }
        }

    }
}
