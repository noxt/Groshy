//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class CategoriesComponent: UIViewController, Component {

    private struct Constants {
        static let rowsCount: CGFloat = 4
        static let horizontalSpacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 8
        static let itemHeight: CGFloat = 86
    }


    // Props

    private let connector: CategoriesConnector!
    var props: CategoriesProps! {
        didSet {
            guard props != oldValue else {
                return
            }
            render()
        }
    }
    private var categories: [CategoriesProps.CategoryInfo]!


    // UI Props

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    // MARK: - Initializator

    init(connector: CategoriesConnector) {
        self.connector = connector
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIKit lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        connector.connect(to: self)
        setup()
    }


    // MARK: - Component lifecycle

    func setup() {
        collectionView.register(CategoryCell.nib, forCellWithReuseIdentifier: CategoryCell.nibIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        props.loadCategoriesList.execute()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width: CGFloat = view.bounds.width - Constants.horizontalSpacing * (Constants.rowsCount - 1)
        layout.itemSize = CGSize(width: width / Constants.rowsCount, height: Constants.itemHeight)
        layout.minimumInteritemSpacing = Constants.horizontalSpacing
        layout.minimumLineSpacing = Constants.verticalSpacing
    }

    func render() {
        switch props.state {
        case let .idle(categories: categories):
            self.categories = categories
            collectionView.reloadData()
            collectionView.isHidden = false
            activityIndicator.isHidden = true

        case .loading:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

}


// MARK: - UICollectionViewDataSource

extension CategoriesComponent: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nibIdentifier, for: indexPath) as! CategoryCell
        let data = categories[indexPath.row]
        let props = CategoryCell.Props(
            title: data.title,
            image: data.icon,
            currentBalance: data.currentBalance,
            isSelected: data.selectCommand == nil
        )
        cell.setup(props: props)
        return cell
    }

}


// MARK: - UICollectionViewDelegate

extension CategoriesComponent: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = categories[indexPath.row]
        data.selectCommand?.execute()
    }

}
