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
    var editCategoryCommand: CommandOf<Category.ID>?
    

    // MARK: - Private Properties

    private weak var collectionView: UICollectionView!
    private var items: [Item] = [.addButton]
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
    }()
    private lazy var doubleTapGesture: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(self.doubleTap(_:)))
        gr.numberOfTapsRequired = 2
        gr.delaysTouchesBegan = true
        return gr
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
        collectionView.addGestureRecognizer(doubleTapGesture)
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
        let realLocation = gesture.location(in: collectionView)
        var shiftedLocation = realLocation
        shiftedLocation.x -= collectionView.contentOffset.x
        
        switch gesture.state {
        case .began:
            guard gesture.view!.frame.contains(shiftedLocation) else {
                return
            }
            
            guard let selectedIndexPath = collectionView.indexPathForItem(at: realLocation) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case .changed:
            guard gesture.view!.frame.contains(shiftedLocation) else {
                collectionView.cancelInteractiveMovement()
                return
            }
            collectionView.updateInteractiveMovementTargetPosition(realLocation)
            
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


// MARK: - Double tap

extension CategoriesDataSource {
    @objc func doubleTap(_ gesture: UIGestureRecognizer) {
        guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }

        switch items[selectedIndexPath.row] {
        case let .category(info: info):
            editCategoryCommand?.execute(with: info.id)
        default:
            break
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
