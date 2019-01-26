//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct KeyboardFeature {

    typealias Digit = Int

    enum Operation: String, CaseIterable {
        case plus = "+"
        case minus = "–"
        case multiplication = "×"
        case division = "÷"
    }
    
}
