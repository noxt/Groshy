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
            storageService: serviceProvider.securityStorageService
        )
        categoriesRepository = CategoriesRepository(
            storageService: serviceProvider.securityStorageService
        )
        transactionRepository = TransactionRepository(
            storageService: serviceProvider.securityStorageService
        )
        hashtagsRepository = HashtagsRepository(
            storageService: serviceProvider.securityStorageService
        )
    }

}
