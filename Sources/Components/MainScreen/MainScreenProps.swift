//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct MainScreenProps {

    enum State: Equatable {
        case idle(currentValue: String)
    }


    let state: State

}


// MARK: - Equatable

extension MainScreenProps: Equatable {
    static func ==(lhs: MainScreenProps, rhs: MainScreenProps) -> Bool {
        return lhs.state == rhs.state
    }
}
