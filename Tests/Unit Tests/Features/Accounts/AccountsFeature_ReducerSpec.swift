//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Unicore
@testable import Groshy


class AccountsFeature_ReducerSpec: QuickSpec {

    typealias State = AccountsFeature.State

    private var disposer: Disposer!
    private var core: Core<State>!

    override func spec() {
        describe("reducer") {
            beforeEach {
                self.disposer = Disposer()
                self.core = Core(state: .initial, reducer: AccountsFeature.reduce)
            }

            afterEach {
                self.disposer = nil
                self.core = nil
            }

            context("on selectAccount action") {
                it("should update state") {
                    let account = Account.make(title: "Test Account")
                    self.emit(action: AccountsFeature.Actions.selectAccount(account)) { (state) -> Bool in
                        return state.currentAccountID == account.id
                    }
                }
            }

            context("on loadingStarted action") {
                it("should update state") {
                    self.emit(action: AccountsFeature.Actions.loadingStarted) { (state) -> Bool in
                        return state.isLoading
                    }
                }
            }

            context("on setAccounts action") {
                it("should update state") {
                    let account1 = Account.make(title: "Test Account 1")
                    let account2 = Account.make(title: "Test Account 2")
                    let account3 = Account.make(title: "Test Account 3")
                    
                    let accounts = [
                        account1.id: account1,
                        account2.id: account2,
                        account3.id: account3
                    ]
                    let newAccounts = accounts.values.map({ $0 })
                    
                    self.emit(action: AccountsFeature.Actions.setAccounts(newAccounts)) { (state) -> Bool in
                        return state.accounts == accounts
                    }
                }
            }

            context("on error action") {
                it("should update state") {
                    let errorMessage = "Error Message"
                    self.emit(action: AccountsFeature.Actions.error(message: errorMessage)) { (state) -> Bool in
                        return state.error == errorMessage
                    }
                }
            }
        }
    }

    private func emit(action: Action, isValid: @escaping (State) -> Bool) {
        waitUntil(timeout: 0.1) { done in
            self.core.observe(with: { (state) in
                if isValid(state) {
                    done()
                }
            }).dispose(on: self.disposer)

            self.core.dispatch(action)
        }
    }
    
}
