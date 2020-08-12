//
//  BookCoverCell.swift
//  OurStory
//
//  Created by Momo on 2020/8/6.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  This file is used by BooksViewController to display all book covers.
//

import UIKit

class BookCoverCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var book: Book? {
        didSet {
            image = book?.coverImage()
        }
    }
    
    var image: UIImage? {
        didSet {
            let corners: UIRectCorner = [.topRight, .bottomRight]
            imageView.image = image?.imageByScalingAndCroppingForSize(targetSize: bounds.size)?.imageWithRoundedCornersSize(cornerRadius: 20, corners: corners)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
