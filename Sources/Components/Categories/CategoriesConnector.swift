//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


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
        
        let transactionsByCategories = groupTransactionsByCategory(transactionsState.transactions)

        var categories: [CategoriesPropsState.CategoryInfo] = []
        for id in categoriesState.sortOrder {
            if let category = categoriesState.categories[id] {
                let balance: Double? = transactionsByCategories[category.id]?.reduce(0, { (res, transaction) -> Double in
                    return res + transaction.value
                })
                
                categories.append(mapCategoryToProps(
                    category: category,
                    isSelected: categoriesState.selectedCategory == category.id,
                    balance: balance ?? 0
                ))
            }
        }
        
//        categories.append(addButtonProps())
        
        guard !categories.isEmpty else {
            return .empty
        }
        
        return .idle(categories: categories)
    }

    private func mapCategoryToProps(category: Category, isSelected: Bool, balance: Double) -> CategoriesPropsState.CategoryInfo {
        let command: PlainCommand?
        if !isSelected {
            command = PlainCommand { [weak self] in
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
    
    private func groupTransactionsByCategory(_ transactions: [Transaction.ID: Transaction]) -> [Category.ID: [Transaction]] {
        var groups = [Category.ID: [Transaction]]()
        
        for transaction in transactions.values {
            if groups[transaction.catagoryID] == nil {
                groups[transaction.catagoryID] = []
            }
            groups[transaction.catagoryID]?.append(transaction)
        }
        
        return groups
    }

    private static let addButtonUUID = Category.ID(rawValue: UUID())
    private func addButtonProps() -> CategoriesPropsState.CategoryInfo {
        return CategoriesPropsState.CategoryInfo(
            id: CategoriesConnector.addButtonUUID,
            title: "Добавить",
            icon: Images.Categories.plus,
            currentBalance: nil,
            selectCommand: CategoriesFeature.Commands.clearSelectedCategory(repositories),
            isSelected: false
        )
    }

}
