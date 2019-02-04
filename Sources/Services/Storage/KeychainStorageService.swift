//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import KeychainAccess


class KeychainStorageService {

    private let keychain: Keychain
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!), encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.keychain = keychain
        self.encoder = encoder
        self.decoder = decoder
    }

}


// MARK: - StorageServiceProtocol

extension KeychainStorageService: StorageServiceProtocol {

    func set<T: Encodable>(value: T, forKey key: StorageServiceKey) throws {
        guard let data = try? encoder.encode(value) else {
            throw StorageServiceError.encodingError
        }

        do {
            try keychain.set(data, key: key.rawValue)
        } catch {
            throw StorageServiceError.savingError
        }
    }

    func getValue<T: Decodable>(forKey key: StorageServiceKey) throws -> T {
        guard let data = try? keychain.getData(key.rawValue), data != nil else {
            throw StorageServiceError.gettingError
        }

        do {
            return try decoder.decode(T.self, from: data!)
        } catch {
            throw StorageServiceError.decodingError
        }
    }

    func deleteValue(forKey key: StorageServiceKey) throws {
        do {
            try keychain.remove(key.rawValue)
        } catch {
            throw StorageServiceError.deletingError
        }
    }

}
