//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Unicore


final class CategoriesConnector: BaseConnector<CategoriesProps> {

    override func mapToProps(state: AppFeature.State) -> CategoriesProps {
        return CategoriesProps(
            state: mapToPropsState(state: state)
        )
    }

    private func mapToPropsState(state: AppFeature.State) -> CategoriesProps.State {
        let categoriesState = state.categoriesState
        let transactionsState = state.transactionState

        guard !categoriesState.isLoading else {
            return .loading
        }
        
        let transactionsByCategories = groupTransactionsByCategory(transactionsState.transactions)

        var categories: [CategoriesProps.CategoryInfo] = []
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
        
        guard !categories.isEmpty else {
            return .empty
        }
        
        return .idle(categories: categories)
    }

    private func mapCategoryToProps(category: Category, isSelected: Bool, balance: Double) -> CategoriesProps.CategoryInfo {
        let command: PlainCommand?
        if !isSelected {
            command = PlainCommand { [weak self] in
                guard let self = self else {
                    return
                }
                CategoriesFeature.Commands.selectCategory(self.repositories).execute(with: category)
            }
        } else {
            command = nil
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currencyAccounting
        numberFormatter.currencyCode = "BYN"

        return CategoriesProps.CategoryInfo(
            id: category.id,
            title: category.title,
            icon: category.icon.image,
            currentBalance: numberFormatter.string(from: NSNumber(value: balance)),
            selectCommand: command
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

//    private static let addButtonUUID = UUID()
//    private func addButtonProps() -> CategoriesProps.CategoryInfo {
//        return CategoriesProps.CategoryInfo(
//            id: CategoriesConnector.addButtonUUID,
//            title: "Добавить",
//            icon: Images.Categories.plus,
//            currentBalance: nil,
//            selectCommand: addCategoryCommand()
//        )
//    }

}
