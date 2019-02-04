//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class KeyboardConnector: BaseConnector<KeyboardProps> {

    override func mapToProps(state: AppFeature.State) -> KeyboardProps {
        let currentValue = state.keyboardState.currentValue

        return KeyboardProps(
            addDigitCommand: KeyboardFeature.Commands.addDigit(currentValue: currentValue),
            addOperationCommand: KeyboardFeature.Commands.addOperation(currentValue: currentValue),
            addCommaCommand: KeyboardFeature.Commands.addComma(currentValue: currentValue),
            removeLastSymbolCommand: KeyboardFeature.Commands.removeLastSymbol(currentValue: currentValue),
            removeAllCommand: KeyboardFeature.Commands.removeAllCommand()
        )
    }

}
