//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct MainScreenScene: SceneProtocol {

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<MainScreenConnector> {
        let connector = MainScreenConnector(repositories: repositories)
        let viewController = MainScreenViewController(connector: connector)
        viewController.keyboardScene = KeyboardScene.makeScene(with: repositories)
        viewController.accountSelectorScene = AccountSelectorScene.makeScene(with: repositories)
        return Scene(connector, viewController)
    }

}
