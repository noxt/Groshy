//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


final class CategoriesComponent: BaseComponent<CategoriesConnector> {

    // MARK: - Types

    private struct Constants {
        static let rowsCount: CGFloat = 4
        static let horizontalSpacing: CGFloat = 6
        static let verticalSpacing: CGFloat = 6
        static let itemHeight: CGFloat = 84
    }


    // MARK: - Private Properties

    private var dataSource: CategoriesDataSource!


    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!


    // MARK: - UIKit lifecycle

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width: CGFloat = view.bounds.width - Constants.horizontalSpacing * (Constants.rowsCount - 1)
        layout.itemSize = CGSize(width: width / Constants.rowsCount, height: Constants.itemHeight)
        layout.minimumInteritemSpacing = Constants.verticalSpacing
        layout.minimumLineSpacing = Constants.horizontalSpacing
    }

    override func setup() {
        dataSource = CategoriesDataSource(collectionView: collectionView)
        super.setup()
    }

    // MARK: - Component lifecycle

    override func render(old oldProps: CategoriesPropsState?) {
        guard props != nil else {
            return
        }

        switch props! {
        case let .idle(categories: categories, addCategoryCommand: addCategoryCommand, editCategoryCommand: editCategoryCommand):
            dataSource.update(categories: categories)
            dataSource.addCategoryCommand = addCategoryCommand.bound(to: self)
            dataSource.editCategoryCommand = CommandOf<Category.ID> { [unowned self] categoryId in
                editCategoryCommand.execute(with: (self, categoryId))
            }
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            emptyLabel.isHidden = true

        case .loading:
            collectionView.isHidden = true
            emptyLabel.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()

        case .empty:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            emptyLabel.isHidden = false
        }
    }

}
