//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


protocol CategoriesRepositoryProtocol {

    func loadCategories() throws -> [Category]
    func create(category: Category) throws
    func update(category: Category) throws
    func delete(category: Category) throws

}
