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

}
