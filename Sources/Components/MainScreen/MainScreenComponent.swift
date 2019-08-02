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
    }


    // MARK: - IBActions

    @IBAction func createTransaction() {
        props.createTransactionCommand?.execute()
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
        addCommentButton.setImage(Images.Buttons.comment, for: .normal)
        addCommentButton.setImage(Images.Buttons.commentSelected, for: .highlighted)
        addCommentButton.layer.cornerRadius = Constants.cornerRadius
        addCommentButton.defaultBackgroundColor = Colors.white
        addCommentButton.highlightedBackgroundColor = Colors.lightGray
    }

}
