//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class HashtagsRepository: HashtagsRepositoryProtocol {
    
    private let storageService: StorageServiceProtocol
    
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
}


// MARK: - CRUD

extension HashtagsRepository {
    
    func loadHashtags() -> Promise<[Hashtag]> {
        return Promise { seal in
            do {
                seal.fulfill(try storageService.getValue(forKey: .hashtags))
            } catch StorageServiceError.gettingError {
                try storageService.set(value: [Hashtag](), forKey: .hashtags)
                seal.fulfill([])
            }
        }
    }
    
    func create(hashtag: Hashtag) -> Promise<Hashtag> {
        return loadHashtags()
            .then({ (hashtags) -> Promise<[Hashtag]> in
                return .value(hashtags + [hashtag])
            })
            .then({ [weak self] (hashtags) -> Promise<Hashtag> in
                try self?.storageService.set(value: hashtags, forKey: .hashtags)
                return .value(hashtag)
            })
    }
    
    func update(hashtag: Hashtag) -> Promise<Hashtag> {
        return loadHashtags()
            .then({ (hashtags) -> Promise<[Hashtag]> in
                guard let index = hashtags.firstIndex(where: { $0.id == hashtag.id }) else {
                    throw HashtagsRepositoryError.hashtagNotFound
                }
                
                var newHashtags = hashtags
                newHashtags[index] = hashtag
                return .value(newHashtags)
            })
            .then({ [weak self] (hashtags) -> Promise<Hashtag> in
                try self?.storageService.set(value: hashtags, forKey: .hashtags)
                return .value(hashtag)
            })
    }
    
    func delete(hashtag: Hashtag) -> Promise<Void> {
        return loadHashtags()
            .then({ (hashtags) -> Promise<[Hashtag]> in
                guard let index = hashtags.firstIndex(where: { $0.id == hashtag.id }) else {
                    throw HashtagsRepositoryError.hashtagNotFound
                }
                
                var newHashtags = hashtags
                newHashtags.remove(at: index)
                return .value(newHashtags)
            })
            .then({ [weak self] (hashtags) -> Promise<Void> in
                try self?.storageService.set(value: hashtags, forKey: .hashtags)
                return Promise()
            })
    }
    
}
