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
        static let horizontalSpacing: CGFloat = 5
        static let verticalSpacing: CGFloat = 5
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
        layout.minimumInteritemSpacing = Constants.horizontalSpacing
        layout.minimumLineSpacing = Constants.verticalSpacing
    }


    // MARK: - Component lifecycle

    override func setup() {
        dataSource = CategoriesDataSource(collectionView: collectionView)
    }

    override func render(old oldProps: CategoriesPropsState?) {
        guard props != nil else {
            return
        }
        
        switch props! {
        case let .idle(categories: categories, addCategoryCommand: addCategoryCommand):
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            emptyLabel.isHidden = true
            let items = categories + [addCategoryButtonProps(command: addCategoryCommand.bound(to: self))]
            dataSource.update(categories: items)

        case .loading:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            emptyLabel.isHidden = true
            activityIndicator.startAnimating()
            
        case .empty:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            emptyLabel.isHidden = false
        }
    }
    
    private static let addButtonUUID = Category.ID(rawValue: UUID())
    private func addCategoryButtonProps(command: Command) -> CategoriesPropsState.CategoryInfo {
        return CategoriesPropsState.CategoryInfo(
            id: CategoriesComponent.addButtonUUID,
            title: "Добавить",
            icon: Images.Categories.plus,
            currentBalance: nil,
            selectCommand: command,
            isSelected: false
        )
    }

}
