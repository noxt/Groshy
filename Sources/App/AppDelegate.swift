//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Unicore


typealias AppCore = Core<AppFeature.State>


let core = AppCore(state: .initial, reducer: AppFeature.reduce)


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let repositories = RepositoryProvider()

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

//        cleanDB()
//        AccountsFeature.Commands.createAccount(repositories).execute(with: Account(id: Account.ID(rawValue: UUID()), title: "ЗП"))
        
        TransactionsFeature.Commands.loadTransactionsList(repositories).execute()
        AccountsFeature.Commands.loadAccountsList(repositories).execute()
        CategoriesFeature.Commands.loadCategoriesList(repositories).execute()

        let mainComponent = MainScreenComponent.build(with: repositories)
        let navigationController = UINavigationController(rootViewController: mainComponent)

        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = Colors.white
        navigationController.navigationBar.tintColor = Colors.gray

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        core.dispatch(AppFeature.Actions.willEnterForeground)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        core.dispatch(AppFeature.Actions.didEnterBackground)
    }

    private func cleanDB() {
        try? KeychainStorageService().deleteValue(forKey: .accounts)
        try? KeychainStorageService().deleteValue(forKey: .categories)
        try? KeychainStorageService().deleteValue(forKey: .transactions)
    }

}


extension UIApplicationDelegate {
    static var current: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
