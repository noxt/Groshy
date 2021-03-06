//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct Category: Codable, Identifiable {

    typealias RawIdentifier = UUID

    let id: ID
    let icon: Icon
    let title: String

}
