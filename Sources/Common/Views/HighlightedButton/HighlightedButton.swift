//
//  Created by Dmitry Ivanenko on 25/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


@IBDesignable
final class HighlightedButton: UIButton {

    @IBInspectable var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    @IBInspectable var highlightedBackgroundColor: UIColor?

    override var isHighlighted: Bool {
        didSet {
            adjustsImageWhenHighlighted = false
            backgroundColor = isHighlighted ? highlightedBackgroundColor : defaultBackgroundColor
        }
    }

}
