//
//  Created by Dmitry Ivanenko on 23/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Unicore
@testable import Groshy


class AccountsReducerTests: BaseReducerTests<AccountsFeature.State> {


    override func setUp() {
        super.setUp()
        core = Core(state: .initial, reducer: AccountsFeature.reduce)
    }

    override func tearDown() {
        core = nil
        super.tearDown()
    }


    func test__CurrentAccountSelected() {
        let account = makeAccount(title: "Test Account")
        XCTAssertState(action: AccountsFeature.Actions.CurrentAccountSelected(accountID: account.id)) { (state) -> Bool in
            return state.currentAccountID == account.id
        }
    }

    func test__LoadingStarted() {
        XCTAssertState(action: AccountsFeature.Actions.LoadingStarted()) { (state) -> Bool in
            return state.isLoading
        }
    }

    func test__AccountsUpdated() {
        let account1 = makeAccount(title: "Test Account 1")
        let account2 = makeAccount(title: "Test Account 2")
        let account3 = makeAccount(title: "Test Account 3")

        let accounts = [
            account1.id: account1,
            account2.id: account2,
            account3.id: account3
        ]

        XCTAssertState(action: AccountsFeature.Actions.AccountsUpdated(accounts: accounts)) { (state) -> Bool in
            return state.accounts == accounts
        }
    }

    func test__Error() {
        let errorMessage = "Error Message"
        XCTAssertState(action: AccountsFeature.Actions.Error(message: errorMessage)) { (state) -> Bool in
            return state.error == errorMessage
        }
    }
    
}
