//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class CategoriesConnector: BaseConnector<CategoriesPropsState> {

    override func mapToProps(state: AppFeature.State) -> CategoriesPropsState {
        return CategoriesPropsState(
            categories: categories(from: state),
            addCategoryCommand: addCategoryCommand(repositories),
            editCategoryCommand: editCategoryCommand(repositories),
            deleteCategoryCommand: CategoriesFeature.Commands.deleteCategory(repositories)
        )
    }

}


// MARK: - Categories

private extension CategoriesConnector {

    func categories(from state: AppFeature.State) -> [CategoriesPropsState.CategoryInfo] {
        let categoriesState = state.categoriesState
        let transactionsState = state.transactionState
        
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
        
        return categories
    }
    
    func mapCategoryToProps(category: Category, isSelected: Bool, balance: Double) -> CategoriesPropsState.CategoryInfo {
        let command: Command?
        if !isSelected {
            command = CategoriesFeature.Commands.selectCategory(repositories).bound(to: category)
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


// MARK: - Commands

private extension CategoriesConnector {
    
    func addCategoryCommand(_ repositories: RepositoryProviderProtocol) -> CommandOf<UIViewController> {
        return CommandOf { viewController in
            let createCategoryScreen = CreateCategoryScreenComponent.build(with: repositories, mode: .add)
            createCategoryScreen.modalPresentationStyle = .overCurrentContext
            createCategoryScreen.modalTransitionStyle = .crossDissolve
            viewController.present(createCategoryScreen, animated: true, completion: nil)
        }
    }
    
    func editCategoryCommand(_ repositories: RepositoryProviderProtocol) -> CommandOf<(UIViewController, Category.ID)> {
        return CommandOf { viewController, categoryID in
            let createCategoryScreen = CreateCategoryScreenComponent.build(with: repositories, mode: .edit(categoryID))
            createCategoryScreen.modalPresentationStyle = .overCurrentContext
            createCategoryScreen.modalTransitionStyle = .crossDissolve
            viewController.present(createCategoryScreen, animated: true, completion: nil)
        }
    }
    
}
