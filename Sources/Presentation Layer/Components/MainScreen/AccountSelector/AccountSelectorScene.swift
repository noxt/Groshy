//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct AccountSelectorScene: SceneProtocol {

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<AccountSelectorConnector> {
        let connector = AccountSelectorConnector(repositories: repositories)
        let viewController = AccountSelectorViewController(connector: connector)
        return Scene(connector, viewController)
    }

}

