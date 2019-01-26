//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class KeyboardComponent: BaseComponent<KeyboardProps, KeyboardConnector> {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }

    @IBOutlet var digitsButtons: [UIButton]!
    @IBOutlet weak var commaButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet var operationsButtons: [UIButton]!
    

    override func setup() {
        super.setup()

        for button in digitsButtons {
            setup(button: button)
            button.setTitleColor(Colors.darkGray, for: .normal)
        }

        for button in operationsButtons {
            setup(button: button)
            button.setTitleColor(Colors.gray, for: .normal)
        }

        setup(button: commaButton)
        commaButton.setTitleColor(Colors.gray, for: .normal)

        setup(button: removeButton)
        removeButton.setTitleColor(Colors.gray, for: .normal)
    }

    private func setup(button: UIButton) {
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = Colors.white
    }


    // MARK: - Actions

    @IBAction func digitDidPressed(_ sender: UIButton) {
        guard let digit = KeyboardFeature.Digit(sender.titleLabel?.text ?? "") else {
            return
        }
        props.addDigitCommand.execute(with: digit)
    }

    @IBAction func commaDidPressed() {
        props.addCommaCommand.execute()
    }

    @IBAction func removeDidPressed() {
        props.removeLastSymbolCommand.execute()
    }

    @IBAction func operationDidPressed(_ sender: UIButton) {
        guard let operation = KeyboardFeature.Operation(rawValue: sender.titleLabel?.text ?? "") else {
            return
        }
        props.addOperationCommand.execute(with: operation)
    }

}
