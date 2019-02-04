//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


final class CategoriesComponent: UIViewController, Component {

    // Props

    private let connector: CategoriesConnector!
    var props: CategoriesProps! {
        didSet {
            guard props != oldValue else {
                return
            }
            render()
        }
    }


    // UI Props

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    // MARK: - Initializator

    init(connector: CategoriesConnector) {
        self.connector = connector
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UIKit lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        connector.connect(to: self)
        setup()
    }


    // MARK: - Component lifecycle

    func setup() {
        titleLabel.textColor = Colors.blue
        titleLabel.font = Fonts.Rubik.Medium(size: 15)

        props.loadCategoriesList.execute()
    }

    func render() {
        switch props.state {
        case let .idle(categories: categories):
            titleLabel.text = String(categories.count)
            titleLabel.isHidden = false
            activityIndicator.isHidden = true

        case .loading:
            titleLabel.isHidden = true
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }

}
