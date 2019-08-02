//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class CreateCategoryScreenConnector: BaseConnector<CreateCategoryScreenProps> {

    private var editableCategoryID: Category.ID?

    init(repositories: RepositoryProviderProtocol, editableCategoryID: Category.ID?) {
        self.editableCategoryID = editableCategoryID
        super.init(repositories: repositories)
    }
    
    required init(repositories: RepositoryProviderProtocol) {
        fatalError("init(repositories:) has not been implemented")
    }
    

    override func mapToProps(state: AppFeature.State) -> CreateCategoryScreenProps {
        var selectedCategory: Category? = nil
        if let id = editableCategoryID {
            selectedCategory = state.categoriesState.categories[id]
        }

        let onSave: CommandOf<Category>
        if editableCategoryID == nil {
            onSave = CategoriesFeature.Commands.createCategory(repositories)
        } else {
            onSave = CategoriesFeature.Commands.updateCategory(repositories)
        }
        
        return CreateCategoryScreenProps(
            title: selectedCategory?.title,
            icon: selectedCategory?.icon,
            onSave: onSave,
            categoryID: editableCategoryID
        )
    }

}
