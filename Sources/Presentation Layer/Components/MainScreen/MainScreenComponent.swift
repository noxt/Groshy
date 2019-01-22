//
//  Created by Dmitry Ivanenko on 22/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class MainScreenComponent: BaseComponent<MainScreenProps, MainScreenConnector> {
    
    @IBOutlet weak var accountTitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!


    override func setup() {
        super.setup()

        addButton.tintColor = .red
        backgroundColor = .yellow
    }

    override func updateUI() {
        accountTitleLabel.text = props.currentAccountTitle
    }


    @IBAction func addNewAccount() {
        props.createAccountCommand.execute()
    }

}
