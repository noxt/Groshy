//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


final class CreateCategoryScreenConnector: BaseConnector<CreateCategoryScreenProps> {
    
    override func mapToProps(state: AppFeature.State) -> CreateCategoryScreenProps {
        return CreateCategoryScreenProps(
            title: "Title",
            icon: .car,
            onSave: CategoriesFeature.Commands.createCategory(repositories)
        )
    }

}
