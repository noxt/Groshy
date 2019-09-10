//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


final class CreateCategoryScreenComponent: BaseComponent<CreateCategoryScreenConnector> {

    // MARK: - Types

    private struct Constants {
        struct Icons {
            static let rowsCount: CGFloat = 4
            static let itemSize: CGFloat = 50
        }
    }


    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldBottomLine: UIView!
    @IBOutlet weak var saveButton: HighlightedButton!
    @IBOutlet weak var iconsCollectionView: UICollectionView!


    // MARK: - Private Properties

    private let icons: [Category.Icon] = Category.Icon.allCases
    private var selectedIcon: Category.Icon? {
        didSet {
            checkSaveButtonIsEnabled()
        }
    }


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(close(_:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)

        iconsCollectionView.register(nibWithCellClass: CreateCategoryIconCollectionViewCell.self)
        iconsCollectionView.dataSource = self
        iconsCollectionView.delegate = self
        iconsCollectionView.reloadData()
    }

    override func setup() {
        super.setup()

        setupTitleLabel()
        setupTextField()
        setupSaveButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let layout = iconsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width: CGFloat = (iconsCollectionView.bounds.width - 20) - Constants.Icons.itemSize * Constants.Icons.rowsCount
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = width / (Constants.Icons.rowsCount - 1)
    }

    override func render(old oldProps: CreateCategoryScreenProps?) {
        textField.text = props.title
        selectedIcon = props.icon
    }


    // MARK: - IBActions

    @IBAction func save(_ sender: UIButton) {
        guard let category = buildCategory() else {
            return
        }

        props.onSave.execute(with: category)

        close(sender)
    }

    private func buildCategory() -> Category? {
        guard let title = textField.text, !title.isEmpty else {
            return nil
        }

        guard let icon = selectedIcon else {
            return nil
        }

        let id: Category.ID
        
        switch props.mode {
        case .add:
            id = Category.ID(rawValue: UUID())
        case let .edit(categoryId):
            id = categoryId
        }
        
        return Category(
            id: id,
            icon: icon,
            title: title
        )
    }


    // MARK: - Private Methods

    private func checkSaveButtonIsEnabled() {
        saveButton.isEnabled = textField.text?.isEmpty == false && selectedIcon != nil
    }

}


// MARK: - Setup

extension CreateCategoryScreenComponent {
    
    private func setupTitleLabel() {
        titleLabel.font = Fonts.Rubik.Medium(size: 24)
        titleLabel.textColor = Colors.black
    }
    
    private func setupTextField() {
        textField.font = Fonts.Rubik.Regular(size: 17)
        textField.textColor = Colors.black
        textField.tintColor = Colors.blue
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        textFieldBottomLine.backgroundColor = Colors.lightGray
    }
    
    private func setupSaveButton() {
        saveButton.layer.cornerRadius = 4
        saveButton.setTitleColor(Colors.white, for: .normal)
        saveButton.setTitleColor(Colors.white, for: .highlighted)
        saveButton.titleLabel?.font = Fonts.Rubik.Medium(size: 17)
        saveButton.defaultBackgroundColor = Colors.blue
        saveButton.highlightedBackgroundColor = Colors.darkBlue
        saveButton.isEnabled = false
    }

}


// MARK: - UIGestureRecognizerDelegate

extension CreateCategoryScreenComponent: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }

    @objc func close(_ sender: Any) {
        textField.resignFirstResponder()
        props.dismissCommand.execute(with: self)
    }

}


// MARK: - UITextField

extension CreateCategoryScreenComponent {

    @objc func textFieldDidChange(textField: UITextField) {
        checkSaveButtonIsEnabled()
    }

}


// MARK: - UICollectionViewDataSource

extension CreateCategoryScreenComponent: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let icon = icons[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withClass: CreateCategoryIconCollectionViewCell.self, for: indexPath)
        cell.configure(with: icon, isSelected: icon == selectedIcon)
        return cell
    }

}


// MARK: - UICollectionViewDelegate

extension CreateCategoryScreenComponent: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newSelectedIcon = icons[indexPath.row]
        if selectedIcon == newSelectedIcon {
            selectedIcon = nil
        } else {
            selectedIcon = newSelectedIcon
        }
        collectionView.reloadData()
    }

}
