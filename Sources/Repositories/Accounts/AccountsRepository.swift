//
//  Created by Dmitry Ivanenko on 20/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class AccountsRepository: AccountsRepositoryProtocol {

    private let crudRepository: CRUDRepository<Account>


    init(crudRepository: CRUDRepository<Account>) {
        self.crudRepository = crudRepository
    }

}


// MARK: - CRUD

extension AccountsRepository {
    
    func loadAccounts() -> Promise<[Account]> {
        return crudRepository.loadItems()
    }
    
    func create(account: Account) -> Promise<Account> {
        return crudRepository.create(account)
    }
    
    func update(account: Account) -> Promise<Account> {
        return crudRepository.update(account)
    }
    
    func delete(accountId: Account.ID) -> Promise<Void> {
        return crudRepository.delete(accountId)
    }

}
