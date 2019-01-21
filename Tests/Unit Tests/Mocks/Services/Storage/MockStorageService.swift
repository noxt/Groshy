//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
@testable import Groshy


class MockStorageService: StorageServiceProtocol {

    var spyStorage: [StorageServiceKey: Codable] = [:]

    var spySetError: Error?
    var spySetValue: Encodable?
    var spySetKey: StorageServiceKey?
    func set<T: Encodable>(value: T, forKey key: StorageServiceKey) throws {
        spySetValue = value
        spySetKey = key

        if let error = spySetError {
            throw error
        }

        spyStorage[key] = value as? Codable
    }

    var spyGetError: Error?
    var spyGetKey: StorageServiceKey?
    func getValue<T: Decodable>(forKey key: StorageServiceKey) throws -> T {
        spyGetKey = key

        if let error = spyGetError {
            throw error
        }

        return spyStorage[key] as! T
    }

    var spyDeleteError: Error?
    var spyDeleteKey: StorageServiceKey?
    func deleteValue(forKey key: StorageServiceKey) throws {
        spyDeleteKey = key

        if let error = spyDeleteError {
            throw error
        }

        spyStorage.removeValue(forKey: key)
    }

}
