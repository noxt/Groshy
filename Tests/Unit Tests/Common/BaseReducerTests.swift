//
//  BaseReducerTests.swift
//  GroshyTests
//
//  Created by Dmitry Ivanenko on 23/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Unicore
@testable import Groshy


class BaseReducerTests<State>: XCTestCase {

    var disposer: Disposer!
    var core: Core<State>!

    override func setUp() {
        super.setUp()

        disposer = Disposer()
    }

    override func tearDown() {
        disposer = nil

        super.tearDown()
    }


    func makeAccount(title: String) -> Account {
        return Account(
            id: UUID(),
            title: title
        )
    }

    func XCTAssertState(action: Action, isValid: @escaping (State) -> Bool) {
        let exp = expectation(description: "select current account")

        core.observe { (newState) in
            if isValid(newState) {
                exp.fulfill()
            }
        }.dispose(on: disposer)

        core.dispatch(action)

        wait(for: [exp], timeout: 0.1)
    }

}
