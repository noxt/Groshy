//
//  Created by Dmitry Ivanenko on 26/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


public extension UIView {

    public func addChild(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
