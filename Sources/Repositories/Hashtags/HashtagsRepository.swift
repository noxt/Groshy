//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class HashtagsRepository: HashtagsRepositoryProtocol {
    
    private let crudRepository: CRUDRepository<Hashtag>
    
    
    init(crudRepository: CRUDRepository<Hashtag>) {
        self.crudRepository = crudRepository
    }
    
}


// MARK: - CRUD

extension HashtagsRepository {
    
    func loadHashtags() -> Promise<[Hashtag]> {
        return crudRepository.loadItems()
    }
    
    func create(hashtag: Hashtag) -> Promise<[Hashtag]> {
        return crudRepository.create(hashtag)
    }
    
    func update(hashtag: Hashtag) -> Promise<[Hashtag]> {
        return crudRepository.update(hashtag)
    }
    
    func delete(hashtagId: Hashtag.ID) -> Promise<[Hashtag]> {
        return crudRepository.delete(hashtagId)
    }
    
}
