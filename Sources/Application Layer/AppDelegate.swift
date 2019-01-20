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

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        core.dispatch(AppFeature.Action.WillEnterForeground())
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        core.dispatch(AppFeature.Action.DidEnterBackground())
    }

}


extension UIApplicationDelegate {
    static var current: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
