//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol Component: class {

    associatedtype PropsType

    var props: PropsType! { get set }
    
}
