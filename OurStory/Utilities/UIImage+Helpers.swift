//
//  UIImage+Helpers.swift
//  OurStory
//
//  Created by Momo on 2020/8/7.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

extension UIImage {
    
    // This function rounds the corners of an image
    func imageWithRoundedCornersSize(cornerRadius: CGFloat, corners: UIRectCorner) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        
        UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).addClip()
        // addClip method constaints the draw area
        
        draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // This function scales an image down to a given size and crops the image automatically
    func imageByScalingAndCroppingForSize(targetSize: CGSize) -> UIImage? {
        let sourceImage = self
        let imageSize = sourceImage.size
        let width = imageSize.width
        let height = imageSize.height
        
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        
        var scaleFactor: CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        
        // - 缩略图
        var thumbnailPoint = CGPoint(x: 0.0,y: 0.0)
        
        if imageSize.equalTo(targetSize) == false {
            // If two sizes do not match
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            
            // Update scaleFactor to fill in the target rect
            if (widthFactor > heightFactor) {
                scaleFactor = widthFactor
            } else {
                scaleFactor = heightFactor
            }
            
            // Update width and height after
            scaledWidth  = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if (widthFactor > heightFactor) {
                // crop vetically
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            } else if (widthFactor < heightFactor) {
                // crop horizontally
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width  = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        sourceImage.draw(in: thumbnailRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
