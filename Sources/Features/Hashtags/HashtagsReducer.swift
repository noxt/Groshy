//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension HashtagsFeature {
    
    static func reduce(_ old: State, with action: Action) -> State {
        var state = old
        state.isLoading = false
        state.error = nil
        
        switch action {
        case let Actions.setHashtags(hashtags):
            state.hashtags = hashtags.normalized
            
        case let Actions.selectHashtag(hashtag):
            state.selectedHashtag = hashtag.id
            
        case Actions.clearSelectedHashtag:
            state.selectedHashtag = nil
            
        case Actions.loadingStarted:
            state.isLoading = true
            
        case let Actions.error(message: msg):
            state.error = msg

        default:
            break
        }
        
        return state
    }
    
}
