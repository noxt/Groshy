//
//  Created by Dmitry Ivanenko on 23/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore
import Command


struct CategoriesComponentCommands {

    static func addCategoryCommand(_ repositories: RepositoryProviderProtocol) -> CommandOf<UIViewController> {
        return CommandOf { viewController in
            let createCategoryScreen = CreateCategoryScreenComponent.build(with: repositories, mode: .add)
            createCategoryScreen.modalPresentationStyle = .overCurrentContext
            createCategoryScreen.modalTransitionStyle = .crossDissolve
            viewController.present(createCategoryScreen, animated: true, completion: nil)
        }
    }
    
    static func editCategoryCommand(_ repositories: RepositoryProviderProtocol) -> CommandOf<(UIViewController, Category.ID)> {
        return CommandOf { viewController, categoryID in
            let createCategoryScreen = CreateCategoryScreenComponent.build(with: repositories, mode: .edit(categoryID))
            createCategoryScreen.modalPresentationStyle = .overCurrentContext
            createCategoryScreen.modalTransitionStyle = .crossDissolve
            viewController.present(createCategoryScreen, animated: true, completion: nil)
        }
    }
    
}
