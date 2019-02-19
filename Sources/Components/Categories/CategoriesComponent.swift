//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class CategoriesComponent: BaseComponent<CategoriesConnector> {

    private struct Constants {
        static let rowsCount: CGFloat = 4
        static let horizontalSpacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 8
        static let itemHeight: CGFloat = 86
    }


    // Props

    private var dataSource: CategoriesDataSource!


    // UI Props

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


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

    override func loadInitialData() {
        props.loadCategoriesList.execute()
    }

    override func render(old oldProps: CategoriesProps?) {
        switch props.state {
        case let .idle(categories: categories):
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            dataSource.update(categories: categories)

        case .loading:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

}
