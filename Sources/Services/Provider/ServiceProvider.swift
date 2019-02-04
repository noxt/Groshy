//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class ServiceProvider: ServiceProviderProtocol {

    let configStorageService: StorageServiceProtocol
    let securityStorageService: StorageServiceProtocol

    init(
        configStorageService: StorageServiceProtocol = UserPreferencesStorageService(),
        securityStorageService: StorageServiceProtocol = KeychainStorageService()
        ) {
        self.configStorageService = configStorageService
        self.securityStorageService = securityStorageService
    }

}
