//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


struct KeyboardScene {

    static func makeScene(with repositories: RepositoryProviderProtocol) -> Scene<KeyboardConnector, KeyboardComponent> {
        let connector = KeyboardConnector(repositories: repositories)
        let component = KeyboardComponent(connector: connector)
        return Scene(connector, component)
    }

}
