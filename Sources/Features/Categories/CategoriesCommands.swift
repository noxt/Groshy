//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


extension CategoriesFeature {
    struct Commands {

        static func loadCategoriesList(_ repositories: RepositoryProviderProtocol) -> PlainCommand {
            return PlainCommand {
                core.dispatch(Actions.loadingStarted)

                do {
                    let categories = try repositories.categoriesRepository.loadCategories()

                    let categoriesByID = normalize(categories: categories)
                    core.dispatch(Actions.categoriesUpdated(categories: categoriesByID))

                    let sortOrder = categories.map { $0.id }
                    core.dispatch(Actions.sortOrderUpdated(sortOrder: sortOrder))
                } catch let e {
                    core.dispatch(Actions.error(message: e.localizedDescription))
                }
            }
        }

        static func createCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { newCategory in
                core.dispatch(Actions.loadingStarted)

                do {
                    try repositories.categoriesRepository.create(category: newCategory)
                    let categories = try repositories.categoriesRepository.loadCategories()

                    let categoriesByID = normalize(categories: categories)
                    core.dispatch(Actions.categoriesUpdated(categories: categoriesByID))

                    let sortOrder = categories.map { $0.id }
                    core.dispatch(Actions.sortOrderUpdated(sortOrder: sortOrder))
                } catch let e {
                    core.dispatch(Actions.error(message: e.localizedDescription))
                }
            }
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
