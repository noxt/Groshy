//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit
import Command


extension HashtagsFeature {
    
    struct Commands {
        
        static func loadHashtagsList(_ repositories: RepositoryProviderProtocol) -> Command {
            return Command {
                core.dispatch(Actions.loadingStarted)
                
                repositories.hashtagsRepository.loadHashtags()
                    .done({ (hashtags) in
                        core.dispatch(Actions.setHashtags(hashtags))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }
        
        static func createHashtag(_ repositories: RepositoryProviderProtocol) -> CommandOf<Hashtag> {
            return CommandOf<Hashtag> { hashtag in
                core.dispatch(Actions.loadingStarted)
                
                repositories.hashtagsRepository.create(hashtag: hashtag)
                    .done({ (hashtags) in
                        core.dispatch(Actions.setHashtags(hashtags))
                        core.dispatch(Actions.selectHashtag(hashtag))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }
        
    }
    
}
