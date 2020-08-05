//
//  UIViewController+Extensions.swift
//  OurStory
//
//  Created by Momo on 2020/7/31.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // nothing goes here
    }
    
    // Return the ViewController of the current view
    class func currentViewController(base: UIViewController? = UIApplication.shared.windows[0].rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
}
