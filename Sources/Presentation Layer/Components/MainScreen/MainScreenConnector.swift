//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class MainScreenConnector: BaseConnector<MainScreenProps> {

    override func mapToProps(state: AppFeature.State) -> MainScreenProps {
        return MainScreenProps(
            state: mapToPropsState(state: state)
        )
    }

    private func mapToPropsState(state: AppFeature.State) -> MainScreenProps.State {
        return .idle(currentValue: state.keyboardState.currentValue)
    }

}
