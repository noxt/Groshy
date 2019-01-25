//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class KeyboardConnector: BaseConnector<KeyboardProps> {

    override func mapToProps(state: AppFeature.State) -> KeyboardProps {
        let keyboardState = state.keyboardState

        return KeyboardProps(
            addDigit: KeyboardFeature.Commands.addDigit(currentValue: keyboardState.currentValue),
            addOperation: KeyboardFeature.Commands.addOperation(currentValue: keyboardState.currentValue),
            addComma: KeyboardFeature.Commands.addComma(currentValue: keyboardState.currentValue),
            removeLastSymbol: KeyboardFeature.Commands.removeLastSymbol(currentValue: keyboardState.currentValue)
        )
    }

}
