//
//  Created by Dmitry Ivanenko on 25/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension KeyboardFeature {
    struct State: Codable {

        let expression: String?
        let currentValue: String


        static let initial = State(
            expression: nil,
            currentValue: "0"
        )

    }
}
