//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


struct MainScreenProps: Equatable {
    let currentValue: String
    let isNewTransactionValid: Bool
    let addCategoryCommand: Command<UIViewController>
    let createTransactionCommand: PlainCommand
}
