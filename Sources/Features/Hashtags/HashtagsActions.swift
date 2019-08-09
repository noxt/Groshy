//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension HashtagsFeature {
    enum Actions: Action {
        case setHashtags([Hashtag])
        case selectHashtag(Hashtag)
        case clearSelectedHashtag
        case loadingStarted
        case error(message: String)
    }
}
