//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class KeyboardConnector: BaseConnector<KeyboardProps> {

    override func mapToProps(state: AppFeature.State) -> KeyboardProps {
        return KeyboardProps(
        )
    }

}
