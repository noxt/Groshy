//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
@testable import Groshy


class MockServiceProvider: ServiceProviderProtocol {

    let _configStorageService = MockStorageService()
    let _securityStorageService = MockStorageService()


    var configStorageService: StorageServiceProtocol {
        return _configStorageService
    }

    var securityStorageService: StorageServiceProtocol {
        return _securityStorageService
    }

}
