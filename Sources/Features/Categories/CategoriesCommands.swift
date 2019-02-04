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
                core.dispatch(Actions.LoadingStarted())

                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1.0) {
                    do {
                        let categories = try repositories.categoriesRepository.loadCategories()

                        let categoriesByID = normalize(categories: categories)
                        core.dispatch(Actions.CategoriesUpdated(categories: categoriesByID))

                        let sortOrder = categories.map { $0.id }
                        core.dispatch(Actions.SortOrderUpdated(sortOrder: sortOrder))
                    } catch let e {
                        core.dispatch(Actions.Error(message: e.localizedDescription))
                    }
                }
            }
        }

        static func createCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { newCategory in
                core.dispatch(Actions.LoadingStarted())

                do {
                    try repositories.categoriesRepository.create(category: newCategory)
                    let categories = try repositories.categoriesRepository.loadCategories()

                    let categoriesByID = normalize(categories: categories)
                    core.dispatch(Actions.CategoriesUpdated(categories: categoriesByID))

                    let sortOrder = categories.map { $0.id }
                    core.dispatch(Actions.SortOrderUpdated(sortOrder: sortOrder))

                    core.dispatch(Actions.CurrentCategorySelected(categoryID: newCategory.id))
                } catch let e {
                    core.dispatch(Actions.Error(message: e.localizedDescription))
                }
            }
        }

        static func selectCurrentCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { category in
                core.dispatch(Actions.CurrentCategorySelected(categoryID: category.id))
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
