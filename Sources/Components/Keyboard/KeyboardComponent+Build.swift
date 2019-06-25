//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension KeyboardComponent {
    static func build(with repositories: RepositoryProviderProtocol) -> KeyboardComponent {
        return KeyboardComponent(
            connector: KeyboardConnector(repositories: repositories)
        )
    }
}
