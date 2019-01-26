//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import SnapKit


final class MainScreenComponent: BaseComponent<MainScreenProps, MainScreenConnector> {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    var keyboardView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            keyboardContainer.addSubview(keyboardView)
            keyboardView.snp.makeConstraints { (make) in
                make.edges.equalTo(keyboardContainer)
            }
        }
    }

    @IBOutlet weak var keyboardContainer: UIView!
    @IBOutlet weak var applyButton: UIButton! {
        didSet {
            applyButton.layer.cornerRadius = Constants.cornerRadius
            applyButton.backgroundColor = Colors.blue
            applyButton.setTitleColor(Colors.white, for: .normal)
        }
    }


    override func setup() {
        super.setup()

        backgroundColor = Colors.darkWhite
    }

}
