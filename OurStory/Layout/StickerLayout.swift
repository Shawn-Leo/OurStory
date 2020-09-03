//
//  StickerLayout.swift
//  OurStory
//
//  Created by Momo on 2020/9/3.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class StickerLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
