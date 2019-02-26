//
//  Created by Dmitry Ivanenko on 27/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension Command: Equatable {

    static func ==(lhs: Command<T>, rhs: Command<T>) -> Bool {
        return true
    }

}
