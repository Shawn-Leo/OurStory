//
//  StringExtension.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/27.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//  参考了https://www.jianshu.com/p/f7a3add5b8e7中的代码，特此鸣谢！
//  此文件用于给string类型添加一些用法，使之与python类似，更加实用

import Foundation

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    func toInt() -> Int{
        return Int((self as NSString).intValue)
    }
}
//
//    使用实例
//    let str = "abcdef"
//    str[1 ..< 3] // returns "bc"
//    str[5] // returns "f"
//    str[80] // returns ""
//    str.substring(fromIndex: 3) // returns "def"
//    str.substring(toIndex: str.length - 2) // returns "abcd"
//    let num = "12"
//    num.toInt() // returns 12
