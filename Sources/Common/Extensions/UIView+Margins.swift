//
//  Created by Dmitry Ivanenko on 26/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


public extension UIView {

    public func changeMargings(insets: UIEdgeInsets) {
        if #available(iOS 11, *) {
            directionalLayoutMargins = NSDirectionalEdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
        } else {
            layoutMargins = insets
        }
    }

    public func changeMargins(inset: CGFloat) {
        changeMargings(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    public func changeMargins(horizontal: CGFloat, vertical: CGFloat) {
        changeMargings(insets: UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal))
    }

}
