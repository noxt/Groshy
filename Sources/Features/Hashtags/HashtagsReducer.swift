//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension HashtagsFeature {
    
    static func reduce(_ old: State, with action: Action) -> State {
        var state = old
        
        switch action {
            
        case let Actions.setHashtags(hashtags):
            state.hashtags = normalize(hashtags: hashtags)
            state.isLoading = false
            state.error = nil
            
        case let Actions.selectHashtag(hashtag):
            state.selectedHashtag = hashtag.id
            
        case Actions.clearSelectedHashtag:
            state.selectedHashtag = nil
            
        case Actions.loadingStarted:
            state.isLoading = true
            state.error = nil
            
        case let Actions.error(message: msg):
            state.isLoading = false
            state.error = msg

        default:
            break
        }
        
        return state
    }
    
    private static func normalize(hashtags: [Hashtag]) -> [Hashtag.ID: Hashtag] {
        var dict: [Hashtag.ID: Hashtag] = [:]
        for hashtag in hashtags {
            dict[hashtag.id] = hashtag
        }
        return dict
    }
    
}
