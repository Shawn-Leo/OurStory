//
//  MemoryLayout.swift
//  OurStory
//
//  Created by Momo on 2020/8/13.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class MemoryLayout: UICollectionViewFlowLayout {
    
    // Set the size of the centered cell
    private let PageWidth: CGFloat = 280
    private let PageHeight: CGFloat = 420
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        scrollDirection = UICollectionView.ScrollDirection.horizontal
        itemSize = CGSize(width: PageWidth, height: PageHeight)
        minimumInteritemSpacing = 10
    }
    
    override func prepare() {
        super.prepare()
      
        // The rate at which we scroll the collection view.
        // Sets how fast the collection view will stop scrolling after a user lifts their finger.
        // "fast" means scroll view will decelerate much faster
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
      
        // Sets the content inset of the collection view so that the first book cover will always be centered.
        collectionView?.contentInset = UIEdgeInsets(
            top: 0,
            left: collectionView!.bounds.width / 2 - PageWidth / 2,
            bottom: 0,
            right: collectionView!.bounds.width / 2 - PageWidth / 2
      )
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // Calling the superclass method and return an array that contanins all default layout attributes
        guard let array = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attributes in array {
            // Grab the frame for the current cell attribute
            let itemFrame = attributes.frame
            
            // Calculate the distance between the book cover and the center of the screen
            // Notes that offset = start point - end point, thus contenOffset.x = frame.origin.x - endPoint.x
            let distance = abs(collectionView!.contentOffset.x + collectionView!.contentInset.left - itemFrame.origin.x)
            
            // Scale the book cover between a factor of 0.75 and 1 depending on the distance calculated above
            // 0.7 scales all book covers to ensure them look nice
            let scale = 0.9 * min(max(1 - distance / (collectionView!.bounds.width), 0.75), 1)
            
            // Apply the scale to the book cover
            // Returns an affine transformation matrix constructed from scaling values you provide.
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return array
    }
    
    // Force the layout to recalculate its attributes every time the collection view’s bound changes
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // Snap cells to centre by readjusting the offset
        var newOffset = CGPoint()
        // Grab the current layout of the collection view
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout

        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        //Calculate the current offset wrt. the center of the sreen.
        var offset = proposedContentOffset.x + collectionView!.contentInset.left
        
        if velocity.x > 0 {
            // The user is scrolling to the right
            // ceil returns next biggest number
            offset = cellWidth * ceil(offset / cellWidth)
        } else if velocity.x == 0 {
            //rounds the argument
            offset = cellWidth * round(offset / cellWidth)
        } else if velocity.x < 0 {
            // The user is scrolling to the left
            //removes decimal part of argument
            offset = cellWidth * floor(offset / cellWidth)
        }
        
        newOffset.x = offset - collectionView!.contentInset.left
        newOffset.y = proposedContentOffset.y // y will always be the same...
        return newOffset
    }
    
}
