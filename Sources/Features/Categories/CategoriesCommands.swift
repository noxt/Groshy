//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore
import PromiseKit


extension CategoriesFeature {
    struct Commands {

        static func loadCategoriesList(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.loadingStarted)

                repositories.categoriesRepository.loadCategories()
                    .done({ (categories) in
                        core.dispatch(Actions.setCategories(categories))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        static func createCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { newCategory in
                core.dispatch(Actions.loadingStarted)

                repositories.categoriesRepository.create(category: newCategory)
                    .then({ (_) -> Promise<[Category]> in
                        repositories.categoriesRepository.loadCategories()
                    })
                    .done({ (categories) in
                        core.dispatch(Actions.setCategories(categories))
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }
        
        static func selectCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { category in
                core.dispatch(Actions.selectCategory(category))
            }
        }
        
        static func clearSelectedCategory(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.clearSelectedCategory)
            }
        }

    }
}
