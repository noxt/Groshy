//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct Transaction: Codable, Identifiable {
    
    typealias RawIdentifier = UUID

    let id: ID
    let accountID: Account.ID
    let catagoryID: Category.ID
    let hashtagID: Hashtag.ID?
    let value: Double
    let date: Date

}
