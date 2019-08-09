//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension AddHashtagScreenComponent {
    static func build(with repositories: RepositoryProviderProtocol) -> AddHashtagScreenComponent {
        return AddHashtagScreenComponent(
            connector: AddHashtagScreenConnector(repositories: repositories)
        )
    }
}
