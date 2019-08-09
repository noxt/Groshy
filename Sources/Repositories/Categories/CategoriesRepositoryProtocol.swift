//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


protocol CategoriesRepositoryProtocol {

    func loadCategories() -> Promise<[Category]>
    func create(category: Category) -> Promise<Category>
    func update(category: Category) -> Promise<Category>
    func delete(categoryId: Category.ID) -> Promise<Void>

}
