//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


struct Scene<ConnectorType: Connector, ComponentType: Component>
    where ConnectorType.PropsType == ComponentType.PropsType, ComponentType: UIViewController {

    let connector: ConnectorType
    let component: ComponentType

    init(_ connector: ConnectorType, _ component: ComponentType) {
        self.connector = connector
        self.component = component
    }

    
    var view: UIView! {
        return component.view
    }

}
