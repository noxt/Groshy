//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


struct Scene<ConnectorType: Connector> {

    let connector: ConnectorType
    let viewController: UIViewController

    init(_ connector: ConnectorType, _ viewController: UIViewController) {
        self.connector = connector
        self.viewController = viewController
    }

}

protocol SceneProtocol {
    associatedtype ConnectorType: Connector

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<ConnectorType>
}
