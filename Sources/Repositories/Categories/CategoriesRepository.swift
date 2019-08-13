//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class CategoriesRepository: CategoriesRepositoryProtocol {

    private let crudRepository: CRUDRepository<Category>


    init(crudRepository: CRUDRepository<Category>) {
        self.crudRepository = crudRepository
    }

}


// MARK: - CRUD

extension CategoriesRepository {

    func loadCategories() -> Promise<[Category]> {
        return crudRepository.loadItems()
    }
    
    func create(category: Category) -> Promise<Category> {
        return crudRepository.create(category)
    }
    
    func update(category: Category) -> Promise<Category> {
        return crudRepository.update(category)
    }
    
    func delete(categoryId: Category.ID) -> Promise<Void> {
        return crudRepository.delete(categoryId)
    }

}
