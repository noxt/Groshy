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
        let transactionState = state.transactionState

        guard !categoriesState.isLoading else {
            return .loading
        }

        var categories: [CategoriesProps.CategoryInfo] = []
        for id in categoriesState.sortOrder {
            if let category = categoriesState.categories[id] {
                categories.append(mapCategoryToProps(
                    category: category,
                    isSelected: transactionState.categoryID == category.id
                ))
            }
        }

        categories.append(addButtonProps())

        return .idle(categories: categories)
    }

    private func mapCategoryToProps(category: Category, isSelected: Bool) -> CategoriesProps.CategoryInfo {
        let command: PlainCommand?
        if !isSelected {
            command = PlainCommand { [unowned self] in
                TransactionFeature.Commands.selectCategory(self.repositories).execute(with: category)
            }
        } else {
            command = nil
        }

        return CategoriesProps.CategoryInfo(
            title: category.title,
            icon: category.icon.image,
            currentBalance: "0 BYN",
            selectCommand: command
        )
    }

    private func addButtonProps() -> CategoriesProps.CategoryInfo {
        return CategoriesProps.CategoryInfo(
            title: "Добавить",
            icon: Images.Categories.plus,
            currentBalance: nil,
            selectCommand: PlainCommand { [unowned self] in
                let category = Category(
                    id: Category.ID(),
                    icon: .car,
                    title: "Транспорт"
                )
                CategoriesFeature.Commands.createCategory(self.repositories).execute(with: category)
            }
        )
    }

}
