//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        let currentBalance = state.transactionState.transactions.values.reduce(0, { (result, transaction) -> Double in
            return result + transaction.value
        })
        
        return MainScreenProps(
            currentBalance: NumberFormatter.byn.string(from: NSNumber(value: currentBalance)) ?? "",
            currentValue: state.keyboardState.currentValue,
            createTransactionCommand: MainScreenCommands.createTransactionCommand(repositories, state: state)
        )
    }

}
