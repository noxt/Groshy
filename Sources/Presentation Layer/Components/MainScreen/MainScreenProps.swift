//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


struct MainScreenProps {

    // Input
    let currentAccountTitle: String?
    let counterTitle: String?

    // Output
    let onViewDidLoad: PlainCommand
    let createAccountCommand: PlainCommand

}


// MARK: - Equatable

extension MainScreenProps: Equatable {

    static func == (lhs: MainScreenProps, rhs: MainScreenProps) -> Bool {
        return lhs.currentAccountTitle == rhs.currentAccountTitle
            && lhs.counterTitle == rhs.counterTitle
    }

}
