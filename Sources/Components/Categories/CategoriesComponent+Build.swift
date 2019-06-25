//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension CategoriesComponent {
    static func build(with repositories: RepositoryProviderProtocol) -> CategoriesComponent {
        return CategoriesComponent(
            connector: CategoriesConnector(repositories: repositories)
        )
    }
}
