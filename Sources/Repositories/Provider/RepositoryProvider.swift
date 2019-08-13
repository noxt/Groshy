//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class RepositoryProvider: RepositoryProviderProtocol {

    let accountsRepository: AccountsRepositoryProtocol
    let categoriesRepository: CategoriesRepositoryProtocol
    let transactionRepository: TransactionRepositoryProtocol
    let hashtagsRepository: HashtagsRepositoryProtocol


    init(serviceProvider: ServiceProviderProtocol = ServiceProvider()) {
        accountsRepository = AccountsRepository(
            crudRepository: CRUDRepository<Account>(
                storageService: serviceProvider.securityStorageService,
                itemsStorageKey: .accounts
            )
        )
        categoriesRepository = CategoriesRepository(
            crudRepository: CRUDRepository<Category>(
                storageService: serviceProvider.securityStorageService,
                itemsStorageKey: .categories
            )
        )
        transactionRepository = TransactionRepository(
            crudRepository: CRUDRepository<Transaction>(
                storageService: serviceProvider.securityStorageService,
                itemsStorageKey: .transactions
            )
        )
        hashtagsRepository = HashtagsRepository(
            crudRepository: CRUDRepository(
                storageService: serviceProvider.securityStorageService,
                itemsStorageKey: .hashtags
            )
        )
    }

}
