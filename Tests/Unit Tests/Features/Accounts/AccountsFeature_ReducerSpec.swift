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
        describe("an accounts feature reducer") {
            beforeEach {
                self.disposer = Disposer()
                self.core = Core(state: .initial, reducer: AccountsFeature.reduce)
            }

            afterEach {
                self.disposer = nil
                self.core = nil
            }

            context("when emited CurrentAccountSelected action") {
                var account: Account!
                beforeEach {
                    account = self.makeAccount(title: "Test Account")
                }

                it("should update state") {
                    self.emit(action: AccountsFeature.Actions.currentAccountSelected(accountID: account.id)) { (state) -> Bool in
                        return state.currentAccountID == account.id
                    }
                }
            }

            context("when emited LoadingStarted action") {
                it("should update state") {
                    self.emit(action: AccountsFeature.Actions.loadingStarted) { (state) -> Bool in
                        return state.isLoading
                    }
                }
            }

            context("when emited AccountsUpdated action") {
                var accounts: [Account.ID: Account]!

                beforeEach {
                    let account1 = self.makeAccount(title: "Test Account 1")
                    let account2 = self.makeAccount(title: "Test Account 2")
                    let account3 = self.makeAccount(title: "Test Account 3")

                    accounts = [
                        account1.id: account1,
                        account2.id: account2,
                        account3.id: account3
                    ]
                }

                it("should update state") {
                    self.emit(action: AccountsFeature.Actions.accountsUpdated(accounts: accounts)) { (state) -> Bool in
                        return state.accounts == accounts
                    }
                }
            }

            context("when emited Error action") {
                let errorMessage = "Error Message"

                it("should update state") {
                    self.emit(action: AccountsFeature.Actions.error(message: errorMessage)) { (state) -> Bool in
                        return state.error == errorMessage
                    }
                }
            }
        }
    }


    private func makeAccount(title: String) -> Account {
        return Account(
            id: UUID(),
            title: title
        )
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
