//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension AccountSelectorComponent {
    static func build(with repositories: RepositoryProviderProtocol) -> AccountSelectorComponent {
        return AccountSelectorComponent(
            connector: AccountSelectorConnector(repositories: repositories)
        )
    }
}
