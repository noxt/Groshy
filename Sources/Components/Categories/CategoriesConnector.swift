//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class CategoriesConnector: BaseConnector<CategoriesPropsState> {

    override func mapToProps(state: AppFeature.State) -> CategoriesPropsState {
        return mapToPropsState(state: state)
    }

    private func mapToPropsState(state: AppFeature.State) -> CategoriesPropsState {
        let categoriesState = state.categoriesState
        let transactionsState = state.transactionState

        guard !categoriesState.isLoading else {
            return .loading
        }

        let filteredTransactions = repositories.transactionRepository.filterTransactions(transactionsState.transactions, filter: transactionsState.filter)
        let transactionsByCategories = repositories.transactionRepository.groupTransactionsByCategory(filteredTransactions)

        var categories: [CategoriesPropsState.CategoryInfo] = []
        for id in categoriesState.sortOrder {
            if let category = categoriesState.categories[id] {
                let transactions = transactionsByCategories[category.id] ?? []
                let balance = repositories.transactionRepository.balanceForTransactions(transactions)

                categories.append(mapCategoryToProps(
                    category: category,
                    isSelected: categoriesState.selectedCategory == category.id,
                    balance: balance
                ))
            }
        }

//        guard !categories.isEmpty else {
//            return .empty
//        }

        return .idle(
            categories: categories,
            addCategoryCommand: CategoriesComponentCommands.addCategoryCommand(repositories),
            editCategoryCommand: CategoriesComponentCommands.editCategoryCommand(repositories)
        )
    }

    private func mapCategoryToProps(category: Category, isSelected: Bool, balance: Double) -> CategoriesPropsState.CategoryInfo {
        let command: Command?
        if !isSelected {
            command = Command { [weak self] in
                guard let self = self else {
                    return
                }
                CategoriesFeature.Commands.selectCategory(self.repositories).execute(with: category)
            }
        } else {
            command = CategoriesFeature.Commands.clearSelectedCategory(repositories)
        }

        return CategoriesPropsState.CategoryInfo(
            id: category.id,
            title: category.title,
            icon: category.icon.image,
            currentBalance: NumberFormatter.byn.string(from: NSNumber(value: balance)),
            selectCommand: command,
            isSelected: isSelected
        )
    }

}
