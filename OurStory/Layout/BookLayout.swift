//
//  BookLayout.swift
//  OurStory
//
//  Created by Momo on 2020/8/13.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class BookLayout: UICollectionViewFlowLayout {
    
    static let pageScale = 0.7
    private let PageWidth = CGFloat(280 * pageScale)
    private let PageHeight = CGFloat(420 * pageScale)
    private var numberOfItems = 0  // number of pages in the book
    
    override func prepare() {
        super.prepare()
        
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.normal
        // Grab the number of pages
        numberOfItems = collectionView!.numberOfItems(inSection: 0)
        // Enable paging to let the view scroll at fixed multiples of the collection view's frame width
        collectionView?.isPagingEnabled = true
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        // Return the overall size of the content area
        return CGSize(width: (CGFloat(numberOfItems / 2)) * collectionView!.bounds.width,
                      height: collectionView!.bounds.height - collectionView!.safeAreaInsets.bottom - collectionView!.safeAreaInsets.top)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array: [UICollectionViewLayoutAttributes] = []
        
        for i in 0 ... max(0, numberOfItems - 1) {
            let indexPath = NSIndexPath(item: i, section: 0)
            let attributes = layoutAttributesForItem(at: indexPath as IndexPath)

            if attributes != nil {
                array += [attributes!]
            }
        }
        return array
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        // Set attributes
        let frame = getFrame(collectionView: collectionView!)
        layoutAttributes.frame = frame
        
        let ratio = getRatio(collectionView: collectionView!,
                             indexPath: indexPath)
        
        // Check the current page is within the ratio's threshold
        if (ratio > 0 && indexPath.item % 2 == 1) || (ratio < 0 && indexPath.item % 2 == 0) {
            // Make sure the cover is always visible
            if indexPath.row != 0 {
                return nil
            }
        }

        let rotation = getRotation(indexPath: indexPath, ratio: min(max(ratio, -1), 1))
        layoutAttributes.transform3D = rotation
        
        // Check if indexPath is the first page. If so, make sure its zIndex is always on top of the other pages to avoid flickering effects
        if indexPath.row == 0 {
            layoutAttributes.zIndex = Int.max
        }
        
        return layoutAttributes
    }

}



// MARK: - Attribute Logic Helpers for rotation
extension BookLayout {
    // Use ratios to represent the angle of pages
    // -1 represent 180 degree and 1 represent 0 degree
    
    // getFrame aligns every page's edge to the book's spine, which is in the middle of the collection view.
    func getFrame(collectionView: UICollectionView) -> CGRect {
        var frame = CGRect()
        
        frame.origin.x = (collectionView.bounds.width / 2) - (PageWidth / 2) + collectionView.contentOffset.x
        frame.origin.y = (collectionViewContentSize.height - PageHeight) / 2
        frame.size.width = PageWidth
        frame.size.height = PageHeight
        
        return frame
    }
    
    // getRation calculates the page's ratio.
    func getRatio(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat {
        
        let pageNumber = CGFloat(indexPath.item - indexPath.item % 2) * 0.5
        var ratio: CGFloat = -0.5 + pageNumber - (collectionView.contentOffset.x / collectionView.bounds.width)
        
        // Restricts the page to a ratio between -0.5 and 0.5.
        // Multiplying by 0.1 creates a gap between each page to make it look like they overlap.
        if ratio > 0.5 {
            ratio = 0.5 + 0.1 * (ratio - 0.5)
            
        } else if ratio < -0.5 {
            ratio = -0.5 + 0.1 * (ratio + 0.5)
        }
        
        return ratio
    }
    
    // getAngle returns the angle for rotation
    func getAngle(indexPath: IndexPath, ratio: CGFloat) -> CGFloat {
        // Set rotation
        var angle: CGFloat = 0
        
        if indexPath.item % 2 == 0 {
            // The book's spine is on the left of the page
            angle = (1-ratio) * CGFloat(-CGFloat.pi/2)
        } else {
            // The book's spine is on the right of the page
            angle = (1 + ratio) * CGFloat(CGFloat.pi/2)
        }
        // Make sure the odd and even page don't have the exact same angle
        angle += CGFloat(indexPath.row % 2) / 1000
        return angle
    }
    
    func makePerspectiveTransform() -> CATransform3D {
        // Transform each page
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -2000  // add a bit of perspective to each page
        return transform
    }
    
    // getRotation apply the rotation
    func getRotation(indexPath: IndexPath, ratio: CGFloat) -> CATransform3D {
        var transform = makePerspectiveTransform()
        let angle = getAngle(indexPath: indexPath, ratio: ratio)
        transform = CATransform3DRotate(transform, angle, 0, 1, 0)
        return transform
    }
    
}
