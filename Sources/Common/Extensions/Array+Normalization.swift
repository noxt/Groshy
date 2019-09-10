//
//  Created by Dmitry Ivanenko on 10/09/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable, Element.RawIdentifier: Hashable {
    var normalized: [Array.Element.ID: Array.Element] {
        return Dictionary(uniqueKeysWithValues: self.map({ ($0.id, $0) }))
    }
}
