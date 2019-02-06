//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct CategoriesScene {
    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<CategoriesConnector, CategoriesComponent> {
        let connector = CategoriesConnector(repositories: repositories)
        let component = CategoriesComponent(connector: connector)
        return Scene(connector, component)
    }
}
