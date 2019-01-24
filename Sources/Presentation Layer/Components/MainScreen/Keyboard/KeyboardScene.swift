//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct KeyboardScene: SceneProtocol {

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<KeyboardConnector> {
        let connector = KeyboardConnector(repositories: repositories)
        let viewController = KeyboardViewController(connector: connector)
        return Scene(connector, viewController)
    }

}
