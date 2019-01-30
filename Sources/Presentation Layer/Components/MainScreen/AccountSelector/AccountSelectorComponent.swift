//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class AccountSelectorComponent: UIViewController, Component {

    // Props

    private let connector: AccountSelectorConnector!
    var props: AccountSelectorProps! {
        didSet {
            guard props != oldValue else {
                return
            }
            render()
        }
    }


    // UI Props

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    // MARK: - Initializator

    init(connector: AccountSelectorConnector) {
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
        titleLabel.textColor = Colors.blue
        titleLabel.font = Fonts.Rubik.Medium(size: 15)

        amountLabel.textColor = Colors.blue
        amountLabel.font = Fonts.Rubik.Regular(size: 11)

        props.loadAccountsList.execute()
    }

    func render() {
        switch props.state {
        case let .idle(title: title, amount: amount):
            titleLabel.text = title
            amountLabel.text = amount
            containerStackView.isHidden = false
            activityIndicator.isHidden = true
            
        case .loading:
            containerStackView.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

}
