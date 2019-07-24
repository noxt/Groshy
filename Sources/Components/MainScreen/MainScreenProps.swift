//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


struct MainScreenProps: Equatable {
    let currentBalance: String
    let currentValue: String
    let createTransactionCommand: Command?
}
