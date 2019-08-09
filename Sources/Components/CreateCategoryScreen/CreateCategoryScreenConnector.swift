//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class CreateCategoryScreenConnector: BaseConnector<CreateCategoryScreenProps> {

    // MARK: - Private Properties
    
    private var mode: CreateCategoryScreenMode

    
    // MARK: - Initializers
    
    init(repositories: RepositoryProviderProtocol, mode: CreateCategoryScreenMode) {
        self.mode = mode
        super.init(repositories: repositories)
    }
    
    required init(repositories: RepositoryProviderProtocol) {
        fatalError("init(repositories:) has not been implemented")
    }
    

    // MARK: - Lifecycle

    override func mapToProps(state: AppFeature.State) -> CreateCategoryScreenProps {
        let selectedCategory: Category?
        let onSave: CommandOf<Category>
        
        switch mode {
        case .add:
            onSave = CategoriesFeature.Commands.createCategory(repositories)
            selectedCategory = nil

        case let .edit(categoryId):
            onSave = CategoriesFeature.Commands.updateCategory(repositories)
            selectedCategory = state.categoriesState.categories[categoryId]
        }
        
        return CreateCategoryScreenProps(
            title: selectedCategory?.title,
            icon: selectedCategory?.icon,
            onSave: onSave,
            mode: mode
        )
    }

}
