//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


class BaseComponent<PropsType: Equatable>: UIView, Component {

    var props: PropsType! {
        didSet {
            guard props != oldValue else {
                return
            }
            render()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }


    func setup() {

    }

    func render() {

    }
    
}
