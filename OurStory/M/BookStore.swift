//
//  BookStore.swift
//  OurStory
//
//  Created by Momo on 2020/8/6.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This class load data from Books.plist and create Book objects.
//  This class is only created once in the life cycle of the app for each type of memory book.
//

import Foundation
import UIKit

private let _SingletonBookStore = BookStore()

class BookStore {

    class var sharedInstance : BookStore {
        return _SingletonBookStore
    }
    
    func loadBooks(plist: String) -> [Book] {
        var books = [Book]()
        if let path = Bundle.main.path(forResource: plist, ofType: "plist") {
            // Get data from plist file
            let rawData = try! Data(contentsOf: URL(fileURLWithPath: path))
            if let array = try! PropertyListSerialization.propertyList(from: rawData, format: nil) as? NSArray {
                for dict in array as! [NSDictionary] {
                    // Create books
                    let book = Book(dict: dict)
                    books += [book]
                }
            }
        }
        return books
    }
    
}
