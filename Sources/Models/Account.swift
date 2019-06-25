//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct Account: Codable, Equatable, Identifiable {

    typealias RawIdentifier = UUID

    let id: ID
    var title: String
    
}
