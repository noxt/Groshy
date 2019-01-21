//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
@testable import Groshy


class BaseUnitTests: XCTestCase {

    var repositories: RepositoryProviderProtocol!
    var services: MockServiceProvider!


    override func setUp() {
        super.setUp()

        services = MockServiceProvider()
        repositories = RepositoryProvider(serviceProvider: services)
    }

    override func tearDown() {
        repositories = nil
        services = nil

        super.tearDown()
    }

}
