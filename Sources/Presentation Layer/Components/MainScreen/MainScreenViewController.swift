//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


class MainScreenViewController: UIViewController {

    lazy var component = MainScreenComponent.instantiateFromNib()
    var connector: MainScreenConnector!


    fileprivate struct Constants {
        struct Filenames {
            static let Nib: String = "MainScreenComponent"
        }
    }


    init(connector: MainScreenConnector) {
        self.connector = connector
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func loadView() {
        component = MainScreenComponent.instantiateFromNib()
        self.view = component
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        connector.connect(to: component)
    }

}
