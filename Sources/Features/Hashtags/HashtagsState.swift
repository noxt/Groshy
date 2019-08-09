//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension HashtagsFeature {
    struct State: Codable {

        var hashtags: [Hashtag.ID: Hashtag]
        var selectedHashtag: Hashtag.ID?
        var isLoading: Bool
        var error: String?
        

        static let initial = State(
            hashtags: [:],
            selectedHashtag: nil,
            isLoading: false,
            error: nil
        )

    }
}
