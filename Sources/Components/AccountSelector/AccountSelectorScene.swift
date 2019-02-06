//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct AccountSelectorScene {
    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<AccountSelectorConnector, AccountSelectorComponent> {
        let connector = AccountSelectorConnector(repositories: repositories)
        let component = AccountSelectorComponent(connector: connector)
        return Scene(connector, component)
    }
}
