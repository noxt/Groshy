//
//  Created by Dmitry Ivanenko on 28/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class AccountSelectorViewController: BaseViewController<AccountSelectorComponent, AccountSelectorConnector> {

    override func viewDidLoad() {
        super.viewDidLoad()
        component.props.loadAccountsList.execute()
    }

}
