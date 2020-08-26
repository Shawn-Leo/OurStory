//
//  CustomNavigationController.swift
//  OurStory
//
//  Created by Momo on 2020/8/20.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }
    
    // navigationController executes each time you push or pop between view controllers, and you control which animated transition you return from this method
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if let vc = fromVC as? MemoryViewController {
                return vc.animationController(forPresented: toVC, presenting: self, source: fromVC)
            } else {
                return nil
            }
            
        }
        
        if operation == .pop {
            if let vc = toVC as? MemoryViewController {
              return vc.animationController(forDismissed: fromVC)
            } else {
                return nil
            }
        }
        return nil // defaults to the standard transition
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let animationController = animationController as? BookOpeningTransition {
            return animationController.interactionController
        }
        return nil
    }

    

}
