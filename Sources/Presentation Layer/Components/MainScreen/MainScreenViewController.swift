//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class MainScreenViewController: BaseViewController<MainScreenComponent, MainScreenConnector> {

    var keyboardScene: Scene<KeyboardConnector>! {
        didSet {
            component.keyboardView = keyboardScene.viewController.view
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.settings, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.statistics, style: .plain, target: nil, action: nil)
    }

}
