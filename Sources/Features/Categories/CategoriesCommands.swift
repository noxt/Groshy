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
                        update(categories: categories)
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
                        update(categories: categories)
                    })
                    .catch({ (error) in
                        core.dispatch(Actions.error(message: error.localizedDescription))
                    })
            }
        }

        private static func update(categories: [Category]) {
            let categoriesByID = normalize(categories: categories)
            core.dispatch(Actions.categoriesUpdated(categories: categoriesByID))

            let sortOrder = categories.map { $0.id }
            core.dispatch(Actions.sortOrderUpdated(sortOrder: sortOrder))
        }

        private static func normalize(categories: [Category]) -> [Category.ID: Category] {
            var dict: [Category.ID: Category] = [:]
            for category in categories {
                dict[category.id] = category
            }
            return dict
        }

    }
}
