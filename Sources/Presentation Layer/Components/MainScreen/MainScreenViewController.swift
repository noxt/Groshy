//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenViewController: BaseViewController<MainScreenComponent, MainScreenConnector> {

    override func viewDidLoad() {
        super.viewDidLoad()
        component.props.onViewDidLoad.execute()
    }

}
