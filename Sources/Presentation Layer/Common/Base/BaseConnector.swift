//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


class BaseConnector<PropsType>: Connector {

    private let disposer = Disposer()

    let repositories: RepositoryProviderProtocol


    required init(repositories: RepositoryProviderProtocol) {
        self.repositories = repositories
    }


    func connect<T: Component>(to component: T) where T.PropsType == PropsType {
        component.props = mapToProps(state: .initial)
        core.observe(on: .main) { (state) in
            component.props = self.mapToProps(state: state)
        }.dispose(on: disposer)
    }

    func mapToProps(state: AppFeature.State) -> PropsType {
        fatalError("mapToProps(state:) has not been implemented")
    }

}
