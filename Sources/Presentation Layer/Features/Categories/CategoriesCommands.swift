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
