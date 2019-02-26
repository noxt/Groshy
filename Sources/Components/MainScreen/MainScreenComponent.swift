//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenComponent: BaseComponent<MainScreenConnector> {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    // UI Props

    private let accountSelectorScene: Scene<AccountSelectorConnector, AccountSelectorComponent>
    private let categoriesScene: Scene<CategoriesConnector, CategoriesComponent>
    private let keyboardScene: Scene<KeyboardConnector, KeyboardComponent>

    @IBOutlet weak var categoriesTitleLabel: UILabel!
    @IBOutlet weak var categoriesContainer: UIView!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var currentValueContainer: UIView!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var keyboardContainer: UIView!
    @IBOutlet weak var applyButton: HighlightedButton!
    @IBOutlet weak var calendarButton: HighlightedButton!

    private var accountSelectorSceneConfigured = false
    private var categoriesSceneConfigured = false
    private var keyboardSceneConfigured = false


    // MARK: - Initializator

    init(connector: MainScreenConnector,
         accountSelectorScene: Scene<AccountSelectorConnector, AccountSelectorComponent>,
         categoriesScene: Scene<CategoriesConnector, CategoriesComponent>,
         keyboardScene: Scene<KeyboardConnector, KeyboardComponent>
     ) {
        self.accountSelectorScene = accountSelectorScene
        self.categoriesScene = categoriesScene
        self.keyboardScene = keyboardScene

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
        
        setupAccountSelectorScene()
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

        setupKeyboardScene()
        setupCategoriesScene()
    }

    override func render(old oldProps: MainScreenProps?) {
        currentValueLabel.text = props.currentValue
    }

}


// MARK: - Setup

extension MainScreenComponent {

    private func setupAccountSelectorScene() {
        guard !accountSelectorSceneConfigured else {
            return
        }
        accountSelectorSceneConfigured = true

        navigationController?.addChild(accountSelectorScene.component)
        navigationItem.titleView = accountSelectorScene.view
        accountSelectorScene.component.didMove(toParent: navigationController!)
    }

    private func setupKeyboardScene() {
        guard !keyboardSceneConfigured else {
            return
        }
        keyboardSceneConfigured = true

        addChild(keyboardScene.component)
        keyboardContainer.addChild(view: keyboardScene.view)
        keyboardScene.component.didMove(toParent: self)
    }

    private func setupCategoriesScene() {
        guard !categoriesSceneConfigured else {
            return
        }
        categoriesSceneConfigured = true

        addChild(categoriesScene.component)
        categoriesContainer.addChild(view: categoriesScene.view)
        categoriesScene.component.didMove(toParent: self)
    }

    private func setupCategories() {
        categoriesTitleLabel.textColor = Colors.black
        categoriesTitleLabel.font = Fonts.Rubik.Regular(size: 17)

        addCommentButton.tintColor = Colors.gray
        addCommentButton.setImage(Images.Buttons.comment, for: .normal)
        addCommentButton.setImage(Images.Buttons.commentSelected, for: .highlighted)
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
    }

}
