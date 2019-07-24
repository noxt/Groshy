//
//  Created by Dmitry Ivanenko on 27/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


extension CommandOf: Equatable {

    static func ==(lhs: CommandOf<T>, rhs: CommandOf<T>) -> Bool {
        return true
    }

}
