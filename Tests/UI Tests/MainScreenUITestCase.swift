//
//  Created by Dmitry Ivanenko on 09/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest


final class MainScreenUITestCase: XCTestCase {
    
    override func setUp() {
        XCUIApplication().launch()
    }
    
    func testTrue() {
        XCTAssertTrue(true)
    }
    
}
