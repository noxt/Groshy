//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore
import SwifterSwift


final class MainScreenComponent: BaseComponent<MainScreenConnector> {

    // MARK: - Types
    
    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    // MARK: - IBOutlets

    @IBOutlet weak var accountSelectorContainer: UIView!
    @IBOutlet weak var categoriesTitleLabel: UILabel!
    @IBOutlet weak var categoriesContainer: UIView!
    @IBOutlet weak var currentValueContainer: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var keyboardContainer: UIView!
    @IBOutlet weak var addCommentButton: HighlightedButton!
    @IBOutlet weak var applyButton: HighlightedButton!
    @IBOutlet weak var calendarButton: HighlightedButton!
    @IBOutlet weak var addCategoryButton: HighlightedButton!


    // MARK: - Private Properties
    
    private let accountSelectorComponent: AccountSelectorComponent
    private let categoriesComponent: CategoriesComponent
    private let keyboardComponent: KeyboardComponent
    
    private var accountSelectorComponentConfigured = false
    private var categoriesComponentConfigured = false
    private var keyboardComponentConfigured = false


    // MARK: - Initializers

    init(connector: MainScreenConnector,
         accountSelectorComponent: AccountSelectorComponent,
         categoriesComponent: CategoriesComponent,
         keyboardComponent: KeyboardComponent
     ) {
        self.accountSelectorComponent = accountSelectorComponent
        self.categoriesComponent = categoriesComponent
        self.keyboardComponent = keyboardComponent

        super.init(connector: connector)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Component lifecycle

    override func setup() {
        view.backgroundColor = Colors.darkWhite

        setupCategories()
        setupCurrentValue()
        setupCalendarButton()
        setupApplyButton()
        setupAddCommentButton()

        setupAccountSelectorComponent()
        setupKeyboardComponent()
        setupCategoriesComponent()
    }

    override func render(old oldProps: MainScreenProps?) {
        currentValueLabel.text = props.currentValue
        applyButton.isEnabled = props.createTransactionCommand != nil
    }


    // MARK: - IBActions

    @IBAction func addCategory() {
        props.addCategoryCommand.execute(with: self)
    }

    @IBAction func createTransaction() {
        props.createTransactionCommand?.execute()
    }

}


// MARK: - Setup

extension MainScreenComponent {

    private func setupAccountSelectorComponent() {
        guard !accountSelectorComponentConfigured else {
            return
        }
        accountSelectorComponentConfigured = true

        addChild(accountSelectorComponent)
        accountSelectorContainer.addChild(view: accountSelectorComponent.view)
        accountSelectorComponent.didMove(toParent: self)
    }

    private func setupKeyboardComponent() {
        guard !keyboardComponentConfigured else {
            return
        }
        keyboardComponentConfigured = true

        addChild(keyboardComponent)
        keyboardContainer.addChild(view: keyboardComponent.view)
        keyboardComponent.didMove(toParent: self)
    }

    private func setupCategoriesComponent() {
        guard !categoriesComponentConfigured else {
            return
        }
        categoriesComponentConfigured = true

        addChild(categoriesComponent)
        categoriesContainer.addChild(view: categoriesComponent.view)
        categoriesComponent.didMove(toParent: self)
    }

    private func setupCategories() {
        categoriesTitleLabel.textColor = Colors.black
        categoriesTitleLabel.font = Fonts.Rubik.Bold(size: 30)

        addCategoryButton.borderColor = Colors.gray
        addCategoryButton.borderWidth = 1
        addCategoryButton.cornerRadius = addCategoryButton.height / 2
        addCategoryButton.titleLabel?.font = Fonts.Rubik.Regular(size: 12)
        addCategoryButton.setTitleColor(Colors.gray, for: .normal)
        addCategoryButton.setTitleColor(Colors.white, for: .highlighted)
        addCategoryButton.defaultBackgroundColor = Colors.clear
        addCategoryButton.highlightedBackgroundColor = Colors.gray
    }

    private func setupCurrentValue() {
        currentValueContainer.backgroundColor = Colors.white
        currentValueContainer.layer.cornerRadius = Constants.cornerRadius

        currentValueLabel.textColor = Colors.black
        currentValueLabel.font = Fonts.Rubik.Medium(size: 25)
    }

    private func setupCalendarButton() {
        calendarButton.setImage(Images.Buttons.calendar, for: .normal)
        calendarButton.setImage(Images.Buttons.calendarSelected, for: .highlighted)
    }

    private func setupApplyButton() {
        applyButton.layer.cornerRadius = Constants.cornerRadius
        applyButton.setTitleColor(Colors.white, for: .normal)
        applyButton.setTitleColor(Colors.white, for: .highlighted)
        applyButton.titleLabel?.font = Fonts.Rubik.Medium(size: 17)
        applyButton.defaultBackgroundColor = Colors.blue
        applyButton.highlightedBackgroundColor = Colors.darkBlue
    }
    
    private func setupAddCommentButton() {
        addCommentButton.tintColor = Colors.gray
        addCommentButton.setImage(Images.Buttons.comment, for: .normal)
        addCommentButton.setImage(Images.Buttons.commentSelected, for: .highlighted)
        addCommentButton.layer.cornerRadius = Constants.cornerRadius
        addCommentButton.defaultBackgroundColor = Colors.white
        addCommentButton.highlightedBackgroundColor = Colors.lightGray
    }

}
