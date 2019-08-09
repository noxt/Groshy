//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension CreateCategoryScreenComponent {
    static func build(with repositories: RepositoryProviderProtocol, mode: CreateCategoryScreenMode) -> CreateCategoryScreenComponent {
        return CreateCategoryScreenComponent(
            connector: CreateCategoryScreenConnector(repositories: repositories, mode: mode)
        )
    }
}
