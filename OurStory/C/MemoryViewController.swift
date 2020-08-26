//
//  BooksViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/6.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This class is responsible for displaying your list of memory books horizontally.
//

import UIKit

class MemoryViewController: UICollectionViewController {
    
    let menuTransition = SlideInTransition()
    var bookOpenTransition = BookOpeningTransition()
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    /// the gesture recognizer used to pinch the book in and out
    var recognizer: UIGestureRecognizer? {
        didSet {
            if let recognizer = recognizer {
                collectionView?.addGestureRecognizer(recognizer)
            }
        }
    }
    
    var books: [Book]? {
        didSet {
            collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        books = BookStore.sharedInstance.loadBooks(plist: "Books")
        recognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
    }
    
    // MARK: Gesture recognizer action
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactionController = UIPercentDrivenInteractiveTransition()
            // Check that the scale, which is dependent on the distance between the pinch points
            if recognizer.scale >= 1 {
                if recognizer.view == collectionView {
                    // show the pages of the book being pinched
                    self.openBook()
                }
            } else {
                // show the book cover again
                navigationController?.popViewController(animated: true)
            }
        case .changed:
            // While Pinching
            if bookOpenTransition.isPush {
                // obtain the progress of the user’s pinch gesture
                // what is progress?
                let progress = min(max(abs((recognizer.scale - 1)) / 5, 0), 1)
                interactionController?.update(progress)
            } else {
                // isPop
                let progress = min(max(abs((1 - recognizer.scale)), 0), 1)
                interactionController?.update(progress)
            }
        case .ended:
            // Notify the system that the user interaction of the transition is complete.
            interactionController?.finish()
            interactionController = nil
        default:
            break
        }
    }

    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    
    // MARK: -Helper
    /**
     This function restricts the user to select only the book in the middle
     */
    func selectedCell() -> BookCoverCell? {
        if let indexPath = collectionView?.indexPathForItem(at: CGPoint(x: collectionView!.contentOffset.x + collectionView!.bounds.width / 2, y: collectionView!.bounds.height / 2)) {
            if let cell = collectionView?.cellForItem(at: indexPath) as? BookCoverCell {
                return cell
            }
        }
        return nil
    }
    
    func openBook() {
        let bvc = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        bvc.book = selectedCell()?.book
        // create a snapshot after the changes have been incorporated
        // used to give enough time for changes
        bvc.view.snapshotView(afterScreenUpdates: true)
        // UICollectionView loads it's cells on a background thread, so make sure it's loaded before passing it to the animation handler
        // UI相关，转到主线程中执行
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(bvc, animated: true)
            return
        }
    }
    
}


// MARK: UICollectionViewDelegate
extension MemoryViewController {
    
    // Action after an Item is selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Restrict the user to open only the book in the middle
        openBook()
    }
    
}


// MARK: UICollectionViewDataSource
extension MemoryViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let books = books {
            return books.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCoverCell", for: indexPath) as! BookCoverCell
        
        cell.book = books?[indexPath.row]
        
        return cell
    }
}


// MARK: Slide Menu Animation and Book Opening Animation
extension MemoryViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is MenuViewController {
            // Slide Menu Animation
            menuTransition.isPresenting = true
            return menuTransition
        } else if presented is BookViewController {
            // Book Opening Animation
            bookOpenTransition.isPush = true
            bookOpenTransition.interactionController = interactionController
            return bookOpenTransition
        } else {
            return nil
        }
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed is MenuViewController {
            menuTransition.isPresenting = false
            return menuTransition
        } else if dismissed is BookViewController {
            bookOpenTransition.isPush = false
            bookOpenTransition.interactionController = interactionController
            return bookOpenTransition
        } else {
            return nil
        }
        
    }
}
