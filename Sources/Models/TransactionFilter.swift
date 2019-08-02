//
//  Created by Dmitry Ivanenko on 02/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


enum TransactionFilter: Int, Codable {
    case perDay
    case perWeek
    case perMonth
    case perYear
    case allTime
}
