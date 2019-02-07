//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore
import SnapKit


final class MainScreenComponent: UIViewController, Component {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    // Props

    private let connector: MainScreenConnector!
    var props: MainScreenProps! {
        didSet {
            guard props != oldValue else {
                return
            }
            render()
        }
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
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!

    private var accountSelectorSceneConfigured = false
    private var categoriesSceneConfigured = false
    private var keyboardSceneConfigured = false


    // MARK: - Initializator

    init(connector: MainScreenConnector,
         accountSelectorScene: Scene<AccountSelectorConnector, AccountSelectorComponent>,
         categoriesScene: Scene<CategoriesConnector, CategoriesComponent>,
         keyboardScene: Scene<KeyboardConnector, KeyboardComponent>
     ) {
        self.connector = connector
        self.accountSelectorScene = accountSelectorScene
        self.categoriesScene = categoriesScene
        self.keyboardScene = keyboardScene

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.settings, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.statistics, style: .plain, target: nil, action: nil)
        
        setupAccountSelectorScene()
    }


    // MARK: - Component lifecycle

    func setup() {
        view.backgroundColor = Colors.darkWhite

        categoriesTitleLabel.textColor = Colors.black
        categoriesTitleLabel.font = Fonts.Rubik.Regular(size: 17)

        addCommentButton.tintColor = Colors.gray

        currentValueContainer.backgroundColor = Colors.white
        currentValueContainer.layer.cornerRadius = Constants.cornerRadius

        currentValueLabel.textColor = Colors.green
        currentValueLabel.font = Fonts.Rubik.Regular(size: 25)

        calendarButton.setTitleColor(Colors.darkGray, for: .normal)
        calendarButton.backgroundColor = Colors.white
        calendarButton.layer.cornerRadius = Constants.cornerRadius
        calendarButton.titleLabel?.font = Fonts.Rubik.Regular(size: 12)
        calendarButton.tintColor = Colors.darkGray

        applyButton.layer.cornerRadius = Constants.cornerRadius
        applyButton.backgroundColor = Colors.blue
        applyButton.setTitleColor(Colors.white, for: .normal)
        applyButton.titleLabel?.font = Fonts.Rubik.Medium(size: 17)

        setupKeyboardScene()
        setupCategoriesScene()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerButtonImageAndTitle(button: calendarButton)
    }

    func render() {
        switch props.state {
        case let .idle(currentValue: currentValue):
            currentValueLabel.text = currentValue
        }
    }

    func centerButtonImageAndTitle(button: UIButton) {
        let spacing: CGFloat = 9.0

        let imageSize = button.imageView!.frame.size
        let titleSize = button.titleLabel!.frame.size

        button.titleEdgeInsets = UIEdgeInsets(top: -(titleSize.height), left: -imageSize.width, bottom: spacing, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: spacing, left: 0, bottom: -(imageSize.height), right: -titleSize.width)
    }

}


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
        keyboardContainer.addSubview(keyboardScene.view)
        keyboardScene.view.snp.makeConstraints { (make) in
            make.edges.equalTo(keyboardContainer)
        }
        keyboardScene.component.didMove(toParent: self)
    }

    private func setupCategoriesScene() {
        guard !categoriesSceneConfigured else {
            return
        }
        categoriesSceneConfigured = true

        addChild(categoriesScene.component)
        categoriesContainer.addSubview(categoriesScene.view)
        categoriesScene.view.snp.makeConstraints { (make) in
            make.edges.equalTo(categoriesContainer)
        }
        categoriesScene.component.didMove(toParent: self)
    }

}
