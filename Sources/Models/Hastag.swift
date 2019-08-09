//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct Hashtag: Codable, Equatable, Identifiable {
    
    typealias RawIdentifier = UUID
    
    let id: ID
    let title: String

}
