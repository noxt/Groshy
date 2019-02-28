//
//  Created by Dmitry Ivanenko on 05/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension TransactionFeature {

    struct Commands {

        static func selectCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { category in
                core.dispatch(Actions.categorySelected(categoryID: category.id))
            }
        }

        static func createTransaction(_ repositories: RepositoryProviderProtocol) -> Command<Transaction> {
            return Command<Transaction> { transaction in
                core.dispatch(Actions.loadingStarted)
            }
        }

    }

}
