//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


class CategoriesRepository: CategoriesRepositoryProtocol {

    private let storageService: StorageServiceProtocol


    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }


    func loadCategories() throws -> [Category] {
        let categories: [Category]

        do {
            categories = try storageService.getValue(forKey: .categories)
        } catch StorageServiceError.gettingError {
            categories = []
            try storageService.set(value: categories, forKey: .categories)
        }

        return categories
    }

    func create(category: Category) throws {
        var categories = try loadCategories()
        categories.append(category)
        try storageService.set(value: categories, forKey: .categories)
    }

    func update(category: Category) throws {
        var categories = try loadCategories()

        guard let index = categories.firstIndex(where: { $0.id == category.id }) else {
            throw CategoriesRepositoryError.categoryNotFound
        }

        categories[index] = category

        try storageService.set(value: categories, forKey: .categories)
    }

    func delete(category: Category) throws {
        var categories = try loadCategories()

        guard let index = categories.firstIndex(where: { $0.id == category.id }) else {
            throw CategoriesRepositoryError.categoryNotFound
        }

        categories.remove(at: index)

        try storageService.set(value: categories, forKey: .categories)
    }

}
