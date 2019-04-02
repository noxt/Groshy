//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        return MainScreenProps(
            currentValue: state.keyboardState.currentValue,
            addCategoryCommand: MainScreenCommands.addCategoryCommand(repositories),
            createTransactionCommand: TransactionFeature.Commands.createTransaction(repositories, state: state.transactionState)
        )
    }

}
