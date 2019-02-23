//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


protocol AccountsRepositoryProtocol {

    func loadAccounts() -> Promise<[Account]>
    func create(account: Account) -> Promise<Account>
    func update(account: Account) -> Promise<Account>
    func delete(account: Account) -> Promise<Void>

}
