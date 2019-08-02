//
//  Created by Dmitry Ivanenko on 19/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import DifferenceKit
import Command


final class CategoriesDataSource: NSObject {

    // MARK: - Types

    enum Item {
        case category(info: CategoriesPropsState.CategoryInfo)
        case addButton
    }

    
    // MARK: - Public Properties
    
    var addCategoryCommand: Command?
    

    // MARK: - Private Properties

    private weak var collectionView: UICollectionView!
    private var items: [Item] = [.addButton]
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
    }()


    // MARK: - Initializers

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView

        super.init()

        collectionView.register(CategoryCell.nib, forCellWithReuseIdentifier: CategoryCell.nibIdentifier)
        collectionView.register(AddCategoryCell.nib, forCellWithReuseIdentifier: AddCategoryCell.nibIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(longPressGesture)
    }


    // MARK: - Public methods

    func update(categories: [CategoriesPropsState.CategoryInfo]) {
        let newItems: [Item] = categories.map({ Item.category(info: $0) }) + [Item.addButton]
        let changeSet = StagedChangeset(source: items, target: newItems)
        collectionView.reload(using: changeSet) { (categories) in
            self.items = categories
        }
    }

}


// MARK: - UICollectionViewDataSource

extension CategoriesDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch items[indexPath.row]  {
        case let .category(info: info):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nibIdentifier, for: indexPath) as! CategoryCell
            cell.setup(props: info)
            return cell
        case .addButton:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCell.nibIdentifier, for: indexPath) as! AddCategoryCell
            return cell
        }
    }

}


// MARK: - UICollectionViewDelegate

extension CategoriesDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        switch items[indexPath.row] {
        case let .category(info: info):
            info.selectCommand?.execute()
        case .addButton:
            addCategoryCommand?.execute()
        }
    }
}


// MARK: - Moving

extension CategoriesDataSource {

    private var maxAvailablePositionForMove: Int {
        return items.count - 2
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.row <= maxAvailablePositionForMove
    }

    @objc func longTap(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            if gesture.view!.frame.contains(gesture.location(in: gesture.view!)) {
                collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            } else {
                collectionView.cancelInteractiveMovement()
            }
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromIndex = sourceIndexPath.row
        let toIndex = min(destinationIndexPath.row, maxAvailablePositionForMove)
        
        let info = items.remove(at: fromIndex)
        items.insert(info, at: toIndex)

        if case .category(info: let info) = info {
            core.dispatch(CategoriesFeature.Actions.moveCategory(info.id, toPosition: toIndex))
        }
    }

}


// MARK: - Differentiable

private let addCategoryButtonID = Category.ID(rawValue: UUID())

extension CategoriesDataSource.Item: Differentiable {
    
    func isContentEqual(to source: CategoriesDataSource.Item) -> Bool {
        switch (self, source) {
        case (.addButton, .addButton):
            return true
        case let (.category(info: infoA), .category(info: infoB)):
            return infoA == infoB
        default:
            return false
        }
    }
    
    var differenceIdentifier: Category.ID {
        switch self {
        case .addButton:
            return addCategoryButtonID
        case let .category(info: info):
            return info.id
        }
    }

}
