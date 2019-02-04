//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol Connector: class {

    associatedtype PropsType
    
    func connect<T: Component>(to component: T) where T.PropsType == PropsType
    func mapToProps(state: AppFeature.State) -> PropsType

}
