//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol RepositoryProviderProtocol {

    var accountsRepository: AccountsRepositoryProtocol { get }
    var categoriesRepository: CategoriesRepositoryProtocol { get }

}
