//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class KeyboardComponent: BaseComponent<KeyboardProps> {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }

    @IBOutlet var digitsButtons: [UIButton]!
    @IBOutlet var operationsButtons: [UIButton]!
    @IBOutlet weak var commaButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    

    override func setup() {
        super.setup()

        setupButtons()
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

    @IBAction func removeAllDidPressed() {
        props.removeAllCommand.execute()
    }

    @IBAction func operationDidPressed(_ sender: UIButton) {
        guard let operation = KeyboardFeature.Operation(rawValue: sender.titleLabel?.text ?? "") else {
            return
        }
        props.addOperationCommand.execute(with: operation)
    }

}


// MARK: - Buttons configuration

extension KeyboardComponent {

    private func setupButtons() {
        for button in digitsButtons {
            setup(button: button)
            button.tintColor = Colors.darkGray
        }

        for button in operationsButtons {
            setup(button: button)
            button.tintColor = Colors.gray
            button.isHidden = true
        }

        setup(button: commaButton)
        commaButton.tintColor = Colors.darkGray
        commaButton.setTitle(NumberFormatter().decimalSeparator, for: .normal)

        setup(button: removeButton)
        removeButton.setImage(Images.delete, for: .normal)
        removeButton.tintColor = Colors.gray

        let removeAllTap = UILongPressGestureRecognizer(target: self, action: #selector(removeAllDidPressed))
        removeButton.addGestureRecognizer(removeAllTap)
    }

    private func setup(button: UIButton) {
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = Colors.white
        button.titleLabel?.font = Fonts.Rubik.Regular(size: 25)
    }

}
