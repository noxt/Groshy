//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Result


protocol StorageServiceProtocol {
    func set<T: Encodable>(value: T, forKey key: StorageServiceKey) throws
    func getValue<T: Decodable>(forKey key: StorageServiceKey) throws -> T
    func deleteValue(forKey key: StorageServiceKey) throws
}
