//
//  Created by Dmitry Ivanenko on 18/03/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol InitConfigurable {
    init()
}


extension InitConfigurable {
    init(configure: (Self) -> Void) {
        self.init()
        configure(self)
    }
}


extension NSObject: InitConfigurable { }
