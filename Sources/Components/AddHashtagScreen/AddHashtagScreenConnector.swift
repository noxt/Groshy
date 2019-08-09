//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class AddHashtagScreenConnector: BaseConnector<AddHashtagScreenPropsState> {
    
    override func setup() {
        super.setup()
        HashtagsFeature.Commands.loadHashtagsList(repositories).execute()
    }
    
    override func mapToProps(state: AppFeature.State) -> AddHashtagScreenPropsState {
        return AddHashtagScreenPropsState(
            hashtags: Array(state.hashtagsState.hashtags.values.prefix(10)),
            saveCommand: HashtagsFeature.Commands.createHashtag(repositories)
        )
    }

}
