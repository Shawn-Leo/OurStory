//
//  BookViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/7.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This view controller is to display the pages of the book when you select a book from BooksViewController.
//

import UIKit

class BookViewController: UICollectionViewController {

    var book: Book? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}



// MARK: UICollectionViewDataSource
extension BookViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let book = book {
            return book.numberOfPages() + 1
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "BookPageCell", for: indexPath) as! BookPageCell
        
        if indexPath.row == 0 {
            // Cover page
            cell.textLabel.text = nil
            cell.image = book?.coverImage()
        }
            
        else {
            // Page with index: indexPath.row - 1
            cell.textLabel.text = "\(indexPath.row)"
            cell.image = book?.pageImage(index: indexPath.row - 1)
        }
        
        return cell
    }
}
