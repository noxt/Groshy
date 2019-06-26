//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


enum AccountSelectorPropsState: Equatable {
    case idle(title: String, amount: String)
    case loading
}
