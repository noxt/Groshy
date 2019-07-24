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
            let alert = UIAlertController(title: "Как назвать категорию?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Введите название категории..."
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                guard let title = alert.textFields?.first?.text else {
                    return
                }
                
                let category = Category(
                    id: Category.ID(rawValue: UUID()),
                    icon: .random(),
                    title: title
                )
                CategoriesFeature.Commands.createCategory(repositories).execute(with: category)
            }))
            
            viewController.present(alert, animated: true)
        }
    }
    
}
