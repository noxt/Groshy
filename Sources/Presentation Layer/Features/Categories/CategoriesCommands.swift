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

                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
                    let categories = [
                        Category(id: UUID(), icon: .car, title: "Транспорт"),
                        Category(id: UUID(), icon: .entertaiment, title: "Развлечения"),
                        Category(id: UUID(), icon: .healt, title: "Здоровье"),
                        Category(id: UUID(), icon: .presents, title: "Подарки"),
                        Category(id: UUID(), icon: .products, title: "Магазин"),
                        Category(id: UUID(), icon: .restaurants, title: "Рестораны"),
                        Category(id: UUID(), icon: .shops, title: "Магазины"),
                    ]

                    let categoriesByID = normalize(categories: categories)
                    core.dispatch(Actions.CategoriesUpdated(categories: categoriesByID))

                    let sortOrder = categories.map { $0.id }
                    core.dispatch(Actions.SortOrderUpdated(sortOrder: sortOrder))
                }
            }
        }

        static func createCategory(_ repositories: RepositoryProviderProtocol) -> Command<Category> {
            return Command<Category> { newCategory in

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
