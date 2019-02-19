//
//  Created by Dmitry Ivanenko on 19/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import DeepDiff


final class CategoriesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Props

    private weak var collectionView: UICollectionView!
    private var categories: [CategoriesProps.CategoryInfo] = []


    // MARK: - Initialization

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView

        super.init()

        collectionView.register(CategoryCell.nib, forCellWithReuseIdentifier: CategoryCell.nibIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }


    // MARK: - Updating data

    func update(categories: [CategoriesProps.CategoryInfo]) {
        let changes = diff(old: self.categories, new: categories)
        collectionView.reload(changes: changes, updateData: { [weak self] in
            self?.categories = categories
        })
    }


    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nibIdentifier, for: indexPath) as! CategoryCell
        cell.setup(props: categories[indexPath.row])
        return cell
    }


    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categories[indexPath.row].selectCommand?.execute()
    }

}