//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol AccountsRepositoryProtocol {

    func loadAccounts() throws -> [Account]
    func create(account: Account) throws
    func update(account: Account) throws
    func delete(account: Account) throws

}
