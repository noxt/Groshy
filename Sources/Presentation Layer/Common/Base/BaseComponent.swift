//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


class BaseComponent<PropsType, ConnectorType>: UIView, Component
    where ConnectorType: Connector, ConnectorType.PropsType == PropsType {

    var props: PropsType! {
        didSet {
            updateUI()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }


    func setup() {

    }

    func updateUI() {

    }
    
}
