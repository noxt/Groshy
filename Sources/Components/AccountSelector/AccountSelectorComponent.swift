//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore
import SwifterSwift


final class AccountSelectorComponent: BaseComponent<AccountSelectorConnector> {

    // MARK: - IBOutlets

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    // MARK: - Lifecycle

    override func setup() {
        titleLabel.textColor = Colors.black
        titleLabel.font = Fonts.Rubik.Bold(size: 30)

        amountLabel.textColor = Colors.blue
        amountLabel.font = Fonts.Rubik.Medium(size: 22)
    }

    override func render(old oldProps: AccountSelectorPropsState?) {
        guard props != nil else {
            return
        }

        switch props! {
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
