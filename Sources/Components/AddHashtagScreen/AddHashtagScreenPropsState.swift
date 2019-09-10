//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


struct AddHashtagScreenPropsState: Equatable {
    let hashtags: [Hashtag]
    let saveCommand: CommandOf<Hashtag>
    let dismissCommand: CommandOf<UIViewController>
}
