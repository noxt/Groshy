//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


protocol HashtagsRepositoryProtocol {
    
    // CRUD
    func loadHashtags() -> Promise<[Hashtag]>
    func create(hashtag: Hashtag) -> Promise<Hashtag>
    func update(hashtag: Hashtag) -> Promise<Hashtag>
    func delete(hashtag: Hashtag) -> Promise<Void>
    
}
