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

    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var categoriesContainer: UIView!
    @IBOutlet weak var currentValueContainer: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var keyboardContainer: UIView!
    @IBOutlet weak var addCommentButton: HighlightedButton!
    @IBOutlet weak var applyButton: HighlightedButton!
    @IBOutlet weak var calendarButton: HighlightedButton!
    @IBOutlet weak var filterButton: UIButton!
    

    // MARK: - Private Properties

    private let categoriesComponent: CategoriesComponent
    private let keyboardComponent: KeyboardComponent

    private var accountSelectorComponentConfigured = false
    private var categoriesComponentConfigured = false
    private var keyboardComponentConfigured = false


    // MARK: - Initializers

    init(connector: MainScreenConnector,
         categoriesComponent: CategoriesComponent,
         keyboardComponent: KeyboardComponent
    ) {
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

        setupCurrentBalanceLabel()
        setupAppTitle()
        setupCurrentValue()
        setupApplyButton()
        setupAddCommentButton()

        setupKeyboardComponent()
        setupCategoriesComponent()
    }

    override func render(old oldProps: MainScreenProps?) {
        currentBalanceLabel.text = props.currentBalance
        currentValueLabel.text = props.currentValue
        applyButton.isEnabled = props.createTransactionCommand != nil
        filterButton.setTitle(props.currentFilter.title, for: .normal)
        
        let hashtagColor = props.hasHashtag ? Colors.red : Colors.gray
        addCommentButton.setTitleColor(hashtagColor, for: .normal)
    }


    // MARK: - IBActions

    @IBAction func createTransaction() {
        props.createTransactionCommand?.execute()
    }

    @IBAction func addHashtag(_ sender: Any) {
        props.addHashtagCommand?.execute(with: self)
    }
    
    @IBAction func changeFilter(_ sender: Any) {
        showFilterMenu()
    }

}


// MARK: - Setup

extension MainScreenComponent {

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

    private func setupCurrentBalanceLabel() {
        currentBalanceLabel.textColor = Colors.darkGray
        currentBalanceLabel.font = Fonts.Rubik.Medium(size: 14)
    }

    private func setupAppTitle() {
        appTitleLabel.textColor = Colors.black
        appTitleLabel.font = Fonts.Rubik.Bold(size: 30)
    }

    private func setupCurrentValue() {
        currentValueContainer.backgroundColor = Colors.white
        currentValueContainer.layer.cornerRadius = Constants.cornerRadius

        currentValueLabel.textColor = Colors.black
        currentValueLabel.font = Fonts.Rubik.Medium(size: 25)
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
        addCommentButton.titleLabel?.font = Fonts.Rubik.Medium(size: 32)
        addCommentButton.layer.cornerRadius = Constants.cornerRadius
    }

}


// MARK: - Long tap on category

extension MainScreenComponent {
    
    private func showFilterMenu() {
        let optionMenu = UIAlertController(title: nil, message: "Расходы", preferredStyle: .actionSheet)
        
        let periods = TransactionFilter.allCases
        for period in periods {
            optionMenu.addAction(title: period.title, style: .default) { _ in
                core.dispatch(TransactionsFeature.Actions.setFilter(period))
            }
        }
        
        optionMenu.addAction(title: "Отменить", style: .cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}


fileprivate extension TransactionFilter {
    var title: String {
        switch self {
        case .perDay:
            return "за день"
        case .perWeek:
            return "за неделю"
        case .perMonth:
            return "за месяц"
        case .perYear:
            return "за год"
        case .allTime:
            return "за все время"
        }
    }
}
