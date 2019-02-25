//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class KeyboardComponent: BaseComponent<KeyboardConnector> {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    // UI Props

    @IBOutlet var digitsButtons: [HighlightedButton]!
    @IBOutlet var operationsButtons: [HighlightedButton]!
    @IBOutlet weak var commaButton: HighlightedButton!
    @IBOutlet weak var removeButton: HighlightedButton!


    // MARK: - Component lifecycle

    override func setup() {
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
            setup(button: button, titleColor: Colors.darkGray)
        }

        for button in operationsButtons {
            setup(button: button, titleColor: Colors.gray)
            button.isHidden = true
        }

        setup(button: commaButton, titleColor: Colors.darkGray)
        commaButton.setTitle(NumberFormatter().decimalSeparator, for: .normal)

        setup(button: removeButton, titleColor: Colors.gray)
        removeButton.setImage(Images.Buttons.delete, for: .normal)
        removeButton.setImage(Images.Buttons.deleteSelected, for: .highlighted)

        let removeAllTap = UILongPressGestureRecognizer(target: self, action: #selector(removeAllDidPressed))
        removeButton.addGestureRecognizer(removeAllTap)
    }

    private func setup(button: HighlightedButton, titleColor: UIColor) {
        button.layer.cornerRadius = Constants.cornerRadius
        button.defaultBackgroundColor = Colors.white
        button.highlightedBackgroundColor = Colors.lightGray
        button.titleLabel?.font = Fonts.Rubik.Regular(size: 25)
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(Colors.white, for: .highlighted)
    }

}
