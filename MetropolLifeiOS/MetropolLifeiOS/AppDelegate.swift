//
//  AppDelegate.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.backgroundColor = .white
        
        return true
    }

    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        if let _ = userActivity.interaction?.intent as? OrderReceptionIntent {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            initialViewController.showMessage()
        }
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let _ = userActivity.interaction?.intent as? OrderReceptionIntent {
            
            if let vc = UIApplication.getTopViewController() as? MainViewController  {
                vc.showMessage()
                } else if let vc = UIApplication.getTopViewController() as? PlacesViewController {
                vc.showMessage()
            }
        }
        
        return true
    }
    
}


extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
