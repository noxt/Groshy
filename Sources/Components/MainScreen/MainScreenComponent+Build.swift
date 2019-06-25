//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension MainScreenComponent {
    static func build(with repositories: RepositoryProviderProtocol) -> MainScreenComponent {
        return MainScreenComponent(
            connector: MainScreenConnector(repositories: repositories),
            accountSelectorComponent: AccountSelectorComponent.build(with: repositories),
            categoriesComponent: CategoriesComponent.build(with: repositories),
            keyboardComponent: KeyboardComponent.build(with: repositories)
        )
    }
}
