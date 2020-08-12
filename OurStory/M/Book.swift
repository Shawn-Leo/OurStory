//
//  Book.swift
//  OurStory
//
//  Created by Momo on 2020/8/6.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This file defines what is needed in a book,
//  including the book cover, the image index for each page and the number of pages.
//  

import Foundation
import UIKit

class Book {

    convenience init (dict: NSDictionary) {
        self.init()
        self.dict = dict
    }
    
    // Use NsDictionary for reference purpose
    // contains key "cover" and "pages"
    var dict: NSDictionary?
    
    
    // Get the cover image of the book
    func coverImage () -> UIImage? {
        if let cover = dict?["cover"] as? String {
            return UIImage(named: cover)
        }
        return nil
    }
    
    // Get the page quicklook image at a given index
    func pageImage (index: Int) -> UIImage? {
        if let pages = dict?["pages"] as? NSArray {
            if let page = pages[index] as? String {
                return UIImage(named: page)
            }
        }
        return nil
    }
    
    // Get the number of pages of the book
    func numberOfPages () -> Int {
        if let pages = dict?["pages"] as? NSArray {
            return pages.count
        }
        return 0
    }

}
