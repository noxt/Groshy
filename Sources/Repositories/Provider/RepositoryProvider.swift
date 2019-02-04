//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class RepositoryProvider: RepositoryProviderProtocol {

    let accountsRepository: AccountsRepositoryProtocol


    init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
        accountsRepository = AccountsRepository(
            storageService: serviceProvider.securityStorageService
        )
    }

}
