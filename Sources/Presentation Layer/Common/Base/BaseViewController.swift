//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


class BaseViewController<ComponentType: Component, ConnectorType: Connector>: UIViewController
    where ComponentType: UIView, ComponentType.PropsType == ConnectorType.PropsType {

    var component: ComponentType!
    var connector: ConnectorType!


    init(connector: ConnectorType) {
        self.connector = connector
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func loadView() {
        component = ComponentType.instantiateFromNib()
        self.view = component
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        connector.connect(to: component)
    }

}
