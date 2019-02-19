//
//  Created by Dmitry Ivanenko on 19/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


class BaseComponent<ConnectorType: Connector>: UIViewController, Component
where ConnectorType.PropsType: Equatable {

    typealias PropsType = ConnectorType.PropsType


    // Props

    private let connector: ConnectorType!
    var props: PropsType! {
        didSet {
            guard props != oldValue else {
                return
            }
            render(old: oldValue)
        }
    }
    

    // MARK: - Initializator

    init(connector: ConnectorType) {
        self.connector = connector
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIKit lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        connector.connect(to: self)
        loadInitialData()
    }

    
    func setup() {

    }

    func render(old oldProps: PropsType?) {

    }

    func loadInitialData() {

    }

}
