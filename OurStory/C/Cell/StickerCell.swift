//
//  StickerCollectionViewCell.swift
//  OurStory
//
//  Created by Momo on 2020/9/3.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class StickerCell: UICollectionViewCell {
    @IBOutlet weak var stickerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.white.cgColor
    }

}
