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
        dataSource.update(categories: props.categories)
        dataSource.addCategoryCommand = props.addCategoryCommand.bound(to: self)
        dataSource.showMenuForCategoryCommand = showMenuForCategoryCommand()
    }

}


// MARK: - Long tap on category

extension CategoriesComponent {
    
    private func showMenuForCategoryCommand() -> CommandOf<CategoriesPropsState.CategoryInfo> {
        return CommandOf { [unowned self] category in
            let menuTitle = "Расходы на \(category.title.lowercased())"
            
            let optionMenu = UIAlertController(title: nil, message: menuTitle, preferredStyle: .actionSheet)
            optionMenu.addAction(title: "История операций", style: .default, handler: self.showHistoryActionHandler(categoryId: category.id))
            optionMenu.addAction(title: "Редактировать", style: .default, handler: self.editActionHandler(categoryId: category.id))
            optionMenu.addAction(title: "Удалить", style: .destructive, handler: self.deleteActionHandler(categoryId: category.id))
            optionMenu.addAction(title: "Отменить", style: .cancel)
            
            self.parent?.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    private func editActionHandler(categoryId: Category.ID) -> ((UIAlertAction) -> Void) {
        return { [unowned self] _ in
            self.props.editCategoryCommand.execute(with: (self, categoryId))
        }
    }
    
    private func deleteActionHandler(categoryId: Category.ID) -> ((UIAlertAction) -> Void) {
        return { [unowned self] _ in
            let dialogMessage = UIAlertController(title: nil, message: "Вы действительно хотите удалить эту категорию?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.props.deleteCategoryCommand.execute(with: categoryId)
            })
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    private func showHistoryActionHandler(categoryId: Category.ID) -> ((UIAlertAction) -> Void) {
        return { _ in
            
        }
    }
    
}
