//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class UserPreferencesStorageService {

    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(userDefaults: UserDefaults = UserDefaults.standard, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

}


// MARK: - StorageServiceProtocol

extension UserPreferencesStorageService: StorageServiceProtocol {

    func set<T: Encodable>(value: T, forKey key: StorageServiceKey) throws {
        do {
            let data = try encoder.encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            throw StorageServiceError.encodingError
        }
    }

    func getValue<T: Decodable>(forKey key: StorageServiceKey) throws -> T {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            throw StorageServiceError.gettingError
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw StorageServiceError.decodingError
        }
    }

    func deleteValue(forKey key: StorageServiceKey) throws {
        userDefaults.removeObject(forKey: key.rawValue)
    }

}
