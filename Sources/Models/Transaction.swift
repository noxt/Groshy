//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct Transaction: Codable {
    typealias ID = UUID

    let id: ID
    let account: Account
    let catagory: Category
    let value: Double
    let date: Date
}
