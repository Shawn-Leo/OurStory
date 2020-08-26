//
//  BookOpeningTransition.swift
//  OurStory
//
//  Created by Momo on 2020/8/20.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class BookOpeningTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Stored properties
    // transforms stores key value pairs, where the key is a UICollectionViewCell and the value is of type CATransform3D. This dictionary tracks each cell’s page transform when the book is open.
    var transforms = [UICollectionViewCell: CATransform3D]()
    var toViewBackgroundColor: UIColor? // defines the color you transition to
    var isPush = true // determines whether the transition is a push, or a pop,
    
    // MARK: Interaction Controller
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // the unit is second
        if isPush {
            return 1
        } else {
            return 1
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        // Check that you’re performing a push
        if isPush {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! MemoryViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! BookViewController
            
            // add toVC to the containing view
            container.addSubview(toVC.view)
            
            // Perform transition
            // set up the starting positions for the to and from view
            self.setStartPositionForPush(fromVC: fromVC, toVC: toVC)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0,
                           usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut,
                           animations: {
                            // A block object containing the changes to commit to the views
                            self.setEndPositionForPush(fromVC: fromVC, toVC: toVC)
            },
                           completion: { finished in
                            self.cleanupPush(fromVC: fromVC, toVC: toVC)
                            transitionContext.completeTransition(finished)
            })
            
        } else {
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! BookViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! MemoryViewController
            
            // Add MemoryViewController below BookViewController within the container view
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
            
            // store the bgcolor
            setStartPositionForPop(fromVC: fromVC, toVC: toVC)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { self.setEndPositionForPop(fromVC: fromVC, toVC: toVC) }, completion: { finished in
                // Clean up the view controller once the animation is done by setting the background color back to it’s original color and showing the book cover.
                self.cleanupPop(fromVC: fromVC, toVC: toVC)
                transitionContext.completeTransition(finished)
            })
            
        }
    }
    
}


// MARK: Helper Methods
extension BookOpeningTransition {
    
    // makePerspectiveTransform returns a transform and adds perspective in the z-axis
    func makePerspectiveTransform() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -2000
        return transform
    }
    
    // closePageCell transitions every cell (or page) to be flat and fit behind the book’s cover
    func closePageCell(cell : BookPageCell) {
        var transform = self.makePerspectiveTransform()
        
        //  check if the cell is a right-hand page
        if cell.layer.anchorPoint.x == 0 {
            // right-hand page
            // Set its angle to 0 to make it flat
            transform = CATransform3DRotate(transform, CGFloat(0), 0, 1, 0)
            // Shift the page be centered behind the cover
            transform = CATransform3DTranslate(transform, -0.9 / 0.7 * cell.layer.bounds.width / 2, 0, 0)
            // Scale the page on the x and y axes by 0.7
            transform = CATransform3DScale(transform, 0.9 / 0.7, 0.9 / 0.7, 1)
        } else {
            // Set the left-hand page’s angle to 180. Since you want the page to be flat, you need to flip it over to the right side of the spine.
            transform = CATransform3DRotate(transform, CGFloat(-CGFloat.pi), 0, 1, 0)
            // Shift the page to be centered behind the cover.
            transform = CATransform3DTranslate(transform, 0.9 / 0.7 * cell.layer.bounds.width / 2, 0, 0)
            // Scale the pages back to 0.9
            transform = CATransform3DScale(transform, 0.9 / 0.7, 0.9 / 0.7, 1)
        }
        
        //10
        cell.layer.transform = transform
    }
    
    func setStartPositionForPush(fromVC: MemoryViewController, toVC: BookViewController) {
        // Closed book state
        // grab the bg color
        toViewBackgroundColor = fromVC.collectionView?.backgroundColor
        toVC.collectionView?.backgroundColor = nil
        
        // hide the selected book cover
        fromVC.selectedCell()?.alpha = 0
        
        
        for cell in toVC.collectionView!.visibleCells as! [BookPageCell] {
            // Save the current transform of each page in its opened state
            transforms[cell] = cell.layer.transform
            
            // transform the pages to closed and update the shadow layer
            closePageCell(cell: cell)
            cell.updateShadowLayer()
            
            // ignore the shadow of the cover image
            if let indexPath = toVC.collectionView?.indexPath(for: cell) {
                if indexPath.row == 0 {
                    cell.shadowLayer.opacity = 0
                }
            }
        }
    }
    
    func setEndPositionForPush(fromVC: MemoryViewController, toVC: BookViewController) {
        // from closed to open
        // Hide all the book covers
        for cell in fromVC.collectionView!.visibleCells as! [BookCoverCell] {
            cell.alpha = 0
        }
        
        // load the previously saved open transforms
        for cell in toVC.collectionView!.visibleCells as! [BookPageCell] {
            cell.layer.transform = transforms[cell]!
            cell.updateShadowLayer(animated: true)
        }
    }
    
       
    func cleanupPush(fromVC: MemoryViewController, toVC: BookViewController) {
        // Add background back to pushed view controller
        toVC.collectionView?.backgroundColor = toViewBackgroundColor
        // Pass the gesture recognizer
        toVC.recognizer = fromVC.recognizer
    }
    
       
    // Pop methods
    func setStartPositionForPop(fromVC: BookViewController, toVC: MemoryViewController) {
        // Remove background from the pushed view controller
        toViewBackgroundColor = fromVC.collectionView?.backgroundColor
        fromVC.collectionView?.backgroundColor = nil
    }
    
       
    func setEndPositionForPop(fromVC: BookViewController, toVC: MemoryViewController) {
        // Get the selected book cover
        let coverCell = toVC.selectedCell()
        // fade in all the covers
        for cell in toVC.collectionView!.visibleCells as! [BookCoverCell] {
            if cell != coverCell {
                cell.alpha = 1
            }
        }
        // transform the cells to a closed state
        for cell in fromVC.collectionView!.visibleCells as! [BookPageCell] {
            closePageCell(cell: cell)
        }
    }
       
    func cleanupPop(fromVC: BookViewController, toVC: MemoryViewController) {
        // Add background back to pushed view controller(sets to the original state)
        fromVC.collectionView?.backgroundColor = self.toViewBackgroundColor
              
        // Pass the gesture recognizer
        toVC.recognizer = fromVC.recognizer
        // Unhide the original book cover
        toVC.selectedCell()?.alpha = 1
    }
    
}
