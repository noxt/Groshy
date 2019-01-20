//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


enum StorageServiceError: Error {

    case encodingError
    case decodingError

    case savingError
    case gettingError
    case deletingError

}
