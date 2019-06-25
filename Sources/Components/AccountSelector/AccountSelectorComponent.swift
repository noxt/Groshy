//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class AccountSelectorComponent: BaseComponent<AccountSelectorConnector> {

    // MARK: - IBOutlets

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    // MARK: - Lifecycle

    override func setup() {
        titleLabel.textColor = Colors.blue
        titleLabel.font = Fonts.Rubik.Medium(size: 15)

        amountLabel.textColor = Colors.blue
        amountLabel.font = Fonts.Rubik.Regular(size: 11)
    }

    override func render(old oldProps: AccountSelectorProps?) {
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
