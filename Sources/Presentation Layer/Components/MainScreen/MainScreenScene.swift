//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct MainScreenScene {

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<MainScreenConnector, MainScreenComponent> {
        let connector = MainScreenConnector(repositories: repositories)
        let component = MainScreenComponent(connector: connector)
        component.keyboardScene = KeyboardScene.makeScene(with: repositories)
        component.accountSelectorScene = AccountSelectorScene.makeScene(with: repositories)
        return Scene(connector, component)
    }

}
