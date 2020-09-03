//
//  UIView+Helpers.swift
//  OurStory
//
//  Created by Momo on 2020/9/3.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

extension UIView {
    /// 切圆角处理操作
    ///
    /// - Parameters:
    ///   - width: UIView 宽度
    ///   - height: UIView 高度
    ///   - corners: UIRectCorner 传递枚举数组 [] 例如： [UIRectCorner.topRight, .topLeft]
    ///   - cornerRadii: CGSize 类型
    func clickCorner(corners: UIRectCorner, cornerRadius: CGFloat) {
        let width = self.frame.width
        let height = self.frame.height
        let maskBezier = UIBezierPath.init(
            roundedRect: CGRect(x: 0, y: 0, width: width, height: height),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        maskLayer.path = maskBezier.cgPath
        self.layer.mask = maskLayer
    }
}
