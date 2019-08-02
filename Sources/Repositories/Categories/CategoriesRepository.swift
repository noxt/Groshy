//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


class CategoriesRepository: CategoriesRepositoryProtocol {

    private let storageService: StorageServiceProtocol


    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }


    func loadCategories() -> Promise<[Category]> {
        return Promise { seal in
            do {
                seal.fulfill(try storageService.getValue(forKey: .categories))
            } catch StorageServiceError.gettingError {
                try storageService.set(value: [Category](), forKey: .categories)
                seal.fulfill([])
            }
        }
    }

    func create(category: Category) -> Promise<Category> {
        return loadCategories()
            .then({ [weak self] (categories) -> Promise<Category> in
                try self?.storageService.set(value: categories + [category], forKey: .categories)
                return .value(category)
            })
    }

    func update(category: Category) -> Promise<Category> {
        return loadCategories()
            .then({ [weak self] (categories) -> Promise<Category> in
                guard let index = categories.firstIndex(where: { $0.id == category.id }) else {
                    throw CategoriesRepositoryError.categoryNotFound
                }
                
                var newCategories = categories
                newCategories[index] = category
                
                try self?.storageService.set(value: newCategories, forKey: .categories)
                
                return .value(category)
            })
    }

    func delete(category: Category) -> Promise<Void> {
        return loadCategories()
            .then({ [weak self] (categories) -> Promise<Void> in
                guard let index = categories.firstIndex(where: { $0.id == category.id }) else {
                    throw CategoriesRepositoryError.categoryNotFound
                }

                var newCategories = categories
                newCategories.remove(at: index)

                try self?.storageService.set(value: newCategories, forKey: .categories)

                return .value(Void())
            })
    }

}
