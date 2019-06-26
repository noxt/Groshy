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

    @IBOutlet weak var categoriesTitleLabel: UILabel!
    @IBOutlet weak var categoriesContainer: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var currentValueContainer: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var keyboardContainer: UIView!
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


    // MARK: - UIKit lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let settingsButton = UIButton(type: .custom)
        settingsButton.setBackgroundImage(Images.Buttons.settings, for: .normal)
        settingsButton.setBackgroundImage(Images.Buttons.settingsSelected, for: .highlighted)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)

        let statisticsButton = UIButton(type: .custom)
        statisticsButton.setBackgroundImage(Images.Buttons.statistics, for: .normal)
        statisticsButton.setBackgroundImage(Images.Buttons.statisticsSelected, for: .highlighted)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statisticsButton)

        setupAccountSelectorComponent()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerButtonImageAndTitle(button: calendarButton)
    }

    private func centerButtonImageAndTitle(button: UIButton) {
        let spacing: CGFloat = 9.0

        let imageSize = button.imageView!.frame.size
        let titleSize = button.titleLabel!.frame.size

        button.titleEdgeInsets = UIEdgeInsets(top: -(titleSize.height), left: -imageSize.width, bottom: spacing, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: spacing, left: 0, bottom: -(imageSize.height), right: -titleSize.width)
    }


    // MARK: - Component lifecycle

    override func setup() {
        view.backgroundColor = Colors.darkWhite

        setupCategories()
        setupCurrentValue()
        setupCalendarButton()
        setupApplyButton()

        setupKeyboardComponent()
        setupCategoriesComponent()
    }

    override func render(old oldProps: MainScreenProps?) {
        currentValueLabel.text = props.currentValue
        applyButton.isEnabled = props.isNewTransactionValid
    }


    // MARK: - IBActions

    @IBAction func addCategory() {
        props.addCategoryCommand.execute(with: self)
    }

    @IBAction func createTransaction() {
        props.createTransactionCommand.execute()
    }

}


// MARK: - Setup

extension MainScreenComponent {

    private func setupAccountSelectorComponent() {
        guard !accountSelectorComponentConfigured else {
            return
        }
        accountSelectorComponentConfigured = true

        navigationController?.addChild(accountSelectorComponent)
        navigationItem.titleView = accountSelectorComponent.view
        accountSelectorComponent.didMove(toParent: navigationController!)
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
        categoriesTitleLabel.font = Fonts.Rubik.Bold(size: 24)

        addCategoryButton.borderColor = Colors.gray
        addCategoryButton.borderWidth = 1
        addCategoryButton.cornerRadius = addCategoryButton.height / 2
        addCategoryButton.titleLabel?.font = Fonts.Rubik.Regular(size: 13)
        addCategoryButton.setTitleColor(Colors.gray, for: .normal)
        addCategoryButton.setTitleColor(Colors.white, for: .highlighted)
        addCategoryButton.defaultBackgroundColor = Colors.clear
        addCategoryButton.highlightedBackgroundColor = Colors.gray
    }

    private func setupCurrentValue() {
        currentValueContainer.backgroundColor = Colors.white
        currentValueContainer.layer.cornerRadius = Constants.cornerRadius

        currentValueLabel.textColor = Colors.green
        currentValueLabel.font = Fonts.Rubik.Regular(size: 25)
    }

    private func setupCalendarButton() {
        calendarButton.setImage(Images.Buttons.calendar, for: .normal)
        calendarButton.setImage(Images.Buttons.calendarSelected, for: .highlighted)
        calendarButton.setTitleColor(Colors.darkGray, for: .normal)
        calendarButton.setTitleColor(Colors.white, for: .highlighted)
        calendarButton.layer.cornerRadius = Constants.cornerRadius
        calendarButton.titleLabel?.font = Fonts.Rubik.Regular(size: 12)
        calendarButton.defaultBackgroundColor = Colors.white
        calendarButton.highlightedBackgroundColor = Colors.lightGray
    }

    private func setupApplyButton() {
        applyButton.layer.cornerRadius = Constants.cornerRadius
        applyButton.setTitleColor(Colors.white, for: .normal)
        applyButton.setTitleColor(Colors.white, for: .highlighted)
        applyButton.titleLabel?.font = Fonts.Rubik.Medium(size: 17)
        applyButton.defaultBackgroundColor = Colors.blue
        applyButton.highlightedBackgroundColor = Colors.darkBlue

        addCommentButton.tintColor = Colors.gray
        addCommentButton.setImage(Images.Buttons.comment, for: .normal)
        addCommentButton.setImage(Images.Buttons.commentSelected, for: .highlighted)
    }

}
