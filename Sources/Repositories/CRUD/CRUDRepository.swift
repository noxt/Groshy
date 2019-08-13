//
//  Created by Dmitry Ivanenko on 13/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import PromiseKit


final class CRUDRepository<Item: Identifiable> where Item.RawIdentifier: Equatable, Item: Codable {
    
    // MARK: - Private Properties
    
    private var storageService: StorageServiceProtocol
    private var itemsStorageKey: StorageServiceKey
    
    
    // MARK: - Initializers
    
    init(storageService: StorageServiceProtocol, itemsStorageKey: StorageServiceKey) {
        self.storageService = storageService
        self.itemsStorageKey = itemsStorageKey
    }
    
    
    // MARK: - CRUDRepositoryProtocol
    
    func loadItems() -> Promise<[Item]> {
        return Promise { seal in
            do {
                seal.fulfill(try storageService.getValue(forKey: itemsStorageKey))
            } catch StorageServiceError.gettingError {
                try storageService.set(value: [Item](), forKey: itemsStorageKey)
                seal.fulfill([])
            }
        }
    }
    
    func create(_ item: Item) -> Promise<[Item]> {
        return loadItems()
            .then({ [unowned self] (items) -> Promise<[Item]> in
                let newItems = items + [item]
                try self.storageService.set(value: newItems, forKey: self.itemsStorageKey)
                return .value(newItems)
            })
    }
    
    func update(_ item: Item) -> Promise<[Item]> {
        return loadItems()
            .then({ [unowned self] (items) -> Promise<[Item]> in
                guard let index = items.firstIndex(where: { $0.id == item.id }) else {
                    throw CRUDRepositoryError.itemNotFound
                }
                
                var newItems = items
                newItems[index] = item
                
                try self.storageService.set(value: newItems, forKey: self.itemsStorageKey)
                
                return .value(newItems)
            })
    }
    
    func delete(_ id: Item.ID) -> Promise<[Item]> {
        return delete(where: { (item) -> Bool in
            return item.id == id
        })
    }
    
    func delete(where condition: @escaping ((Item) -> Bool)) -> Promise<[Item]> {
        return loadItems()
            .then({ (items) -> Promise<[Item]> in
                return .value(items.filter({ item in
                    return !condition(item)
                }))
            })
            .then({ [unowned self] (items) -> Promise<[Item]> in
                try self.storageService.set(value: items, forKey: self.itemsStorageKey)
                return .value(items)
            })
    }
    
}
