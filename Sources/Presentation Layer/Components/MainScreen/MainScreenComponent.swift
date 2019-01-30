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

    var accountSelectorScene: Scene<AccountSelectorConnector, AccountSelectorComponent>!
    var keyboardScene: Scene<KeyboardConnector, KeyboardComponent>!

    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var keyboardContainer: UIView!
    @IBOutlet weak var applyButton: UIButton!

    private var accountSelectorSceneConfigured = false
    private var keyboardSceneConfigured = false


    // MARK: - Initializator

    init(connector: MainScreenConnector) {
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.settings, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.statistics, style: .plain, target: nil, action: nil)
        
        setupAccountSelectorScene()
    }


    // MARK: - Component lifecycle

    func setup() {
        view.backgroundColor = Colors.darkWhite

        applyButton.layer.cornerRadius = Constants.cornerRadius
        applyButton.backgroundColor = Colors.blue
        applyButton.setTitleColor(Colors.white, for: .normal)
        applyButton.titleLabel?.font = Fonts.Rubik.Medium(size: 17)

        setupKeyboardScene()
    }

    func render() {
        switch props.state {
        case let .idle(currentValue: currentValue):
            currentValueLabel.text = currentValue
        }
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

}
