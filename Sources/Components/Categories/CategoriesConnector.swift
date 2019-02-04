//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class CategoriesConnector: BaseConnector<CategoriesProps> {

    override func mapToProps(state: AppFeature.State) -> CategoriesProps {
        return CategoriesProps(
            state: mapToPropsState(state: state),
            loadCategoriesList: CategoriesFeature.Commands.loadCategoriesList(repositories)
        )
    }

    private func mapToPropsState(state: AppFeature.State) -> CategoriesProps.State {
        let categoriesState = state.categoriesState

        guard !categoriesState.isLoading else {
            return .loading
        }

        var categories: [CategoriesProps.CategoryInfo] = []
        for id in categoriesState.sortOrder {
            if let category = categoriesState.categories[id] {
                categories.append(mapCategoryToProps(
                    category: category,
                    isSelected: categoriesState.currentCategoryID == category.id
                ))
            }
        }

        return .idle(categories: categories)
    }

    private func mapCategoryToProps(category: Category, isSelected: Bool) -> CategoriesProps.CategoryInfo {
        let command: PlainCommand?
        if !isSelected {
            command = PlainCommand { [unowned self] in
                CategoriesFeature.Commands.selectCurrentCategory(self.repositories).execute(with: category)
            }
        } else {
            command = nil
        }

        return CategoriesProps.CategoryInfo(
            title: category.title,
            icon: category.icon.image,
            currentBalance: 0,
            selectCommand: command
        )
    }

}