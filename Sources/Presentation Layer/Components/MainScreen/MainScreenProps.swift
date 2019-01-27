//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct MainScreenProps {
    let currentValue: String
}


// MARK: - Equatable

extension MainScreenProps: Equatable {

    static func == (lhs: MainScreenProps, rhs: MainScreenProps) -> Bool {
        return lhs.currentValue == rhs.currentValue
    }

}
