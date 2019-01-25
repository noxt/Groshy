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
                let newValue = currentValue.appending(String(digit))
                core.dispatch(Actions.CurrentValueUpdated(value: newValue))
            }
        }

        static func addOperation(currentValue: String) -> Command<Operation> {
            return Command<Operation> { digit in

            }
        }

        static func addComma(currentValue: String) -> PlainCommand {
            return PlainCommand {
                let formatter = NumberFormatter()
                let newValue = currentValue.appending(formatter.decimalSeparator)
                core.dispatch(Actions.CurrentValueUpdated(value: newValue))
            }
        }

        static func removeLastSymbol(currentValue: String) -> PlainCommand {
            return PlainCommand {
                var newValue = String(currentValue)
                newValue.removeLast()
                core.dispatch(Actions.CurrentValueUpdated(value: newValue))
            }
        }

    }

}
