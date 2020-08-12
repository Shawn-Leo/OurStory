//
//  BooksViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/6.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This class is responsible for displaying your list of books horizontally.
//

import UIKit

class BooksViewController: UICollectionViewController {
    
    var books: [Book]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = BookStore.sharedInstance.loadBooks(plist: "Books")
    }
    
    // MARK: Helpers
    
    func openBook(book: Book?) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("BookViewController") as! BookViewController
        vc.book = book
        // UICollectionView loads it's cells on a background thread, so make sure it's loaded before passing it to the animation handler
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.navigationController?.pushViewController(vc, animated: true)
            return
        })
    }
    
}


// MARK: UICollectionViewDelegate

extension BooksViewController: UICollectionViewDelegate {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var book = books?[indexPath.row]
        openBook(book)
    }
    
}

// MARK: UICollectionViewDataSource

extension BooksViewController: UICollectionViewDataSource {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let books = books {
            return books.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView .dequeueReusableCellWithReuseIdentifier("BookCoverCell", forIndexPath: indexPath) as! BookCoverCell
        
        cell.book = books?[indexPath.row]
        
        return cell
    }
    
}

