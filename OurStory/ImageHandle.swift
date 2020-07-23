//
//  ImageTransform.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/23.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//
//  此文件中定义了处理图片的三个函数，分别为编码imageDecode，转码imageEncode，和另存为imageSave
//  参考了https://www.hangge.com/blog/cache/detail_1711.html中的部分代码，特此鸣谢
//

import Foundation
import UIKit

/***********************************************************************************.
   函数名称：imageFromProjectDecode
   函数功能：实现工程中的图片解码，将图片编码为base64，且经过URL转换的字符串，便于后续传输，为使用【相对路径】调取图片的方法
   参数接口：type: 字符串，为图片的类型，目前只提供jpg和png两种类型的转换
           imageDir: 字符串，为图片在此工程下的相对路径，【不包含后缀】
   返回值：经过编码后的字符串
   例子：假设工程中有一个叫"1.jpg"的图片，可以通过imageFromProjectDecode(type: "jpg", imageDir: "1")来获得编码后的字符串
   更改日志：2020/07/23 由刘相廷创建
   备注：由于使用了Bundle，此函数只能用于已经导入工程中的图片         如果你想要让图片可以不用手动加入到Xcode中，可以选择先新建一个图片文件夹，将这个文件夹提前加入工程中，并在后续操作中将图片保存在那个文件夹下，这样就可以通过相对路径来调用了
.**********************************************************************************/
func imageFromProjectDecode(type: String, imageDir: String) -> String {
    if type == "jpg" {
        let bundlePath = Bundle.main.path(forResource: imageDir, ofType: "jpg")
        let image = UIImage(contentsOfFile: bundlePath!)
        let imageData = image!.jpegData(compressionQuality: 1)
        let base64 = imageData!.base64EncodedString(options: .endLineWithLineFeed).addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return base64
    }
    else if type == "png" {
        let bundlePath = Bundle.main.path(forResource: imageDir, ofType: "png")
        let image = UIImage(contentsOfFile: bundlePath!)
        let imageData = image!.pngData()
        let base64 = imageData!.base64EncodedString(options: .endLineWithLineFeed).addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return base64
    }
    else {
        return "fail to Decode"
    }
}

/***********************************************************************************.
   函数名称：imageOutsideProjectDecode
   函数功能：实现工程外的图片解码，和前面的功能类似，为使用【绝对路径】调取图片的方法
   参数接口：type: 字符串，为图片的类型，目前只提供jpg和png两种类型的转换
           imageDir: 字符串，为图片的绝对路径，【包含后缀】
   返回值：经过编码后的字符串
   例子：假设桌面上有一个叫"1.jpg"的图片，可以通过imageOutsideProjectDecode(type: "jpg", imageDir: "/Users/apple/Desktop/1.jpg")来获得编码后的字符串
   更改日志：2020/07/23 由刘相廷创建
.**********************************************************************************/
func imageOutsideProjectDecode(type: String, imageDir: String?) -> String {
    if type == "jpg" {
        let image = UIImage(contentsOfFile: imageDir!)
        let imageData = image!.jpegData(compressionQuality: 1)
        let base64 = imageData!.base64EncodedString(options: .endLineWithLineFeed).addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return base64
    }
    else if type == "png" {
        let image = UIImage(contentsOfFile: imageDir!)
        let imageData = image!.pngData()
        let base64 = imageData!.base64EncodedString(options: .endLineWithLineFeed).addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        return base64
    }
    else {
        return "fail to Decode"
    }
}
/***********************************************************************************.
   函数名称：imageEncode
   函数功能：将经过base64编码，且经过URL转化的图片转码字符串重新转码成为UIImage图片
   参数接口：base64Data: 经过转化的图片字符串
   返回值：经过转码后得到的图片，为UIImage类型
   例子：假设Data为一个经过了Decode函数编码后的图片，可以通过imageEncode(base64Data: Data)获得原先的UImage
   更改日志：2020/07/23 由刘相廷创建
.**********************************************************************************/
func imageEncode(base64Data: String) -> UIImage {
    let imageData = Data(base64Encoded: base64Data.removingPercentEncoding!)
    guard let image = UIImage(data: imageData!) else { return UIImage() }
    return image
}

/***********************************************************************************.
   函数名称：imageSave
   函数功能：将UIImage另存到其他位置
   参数接口：imageName：文件名
           type：另存的文件种类，可以为jpg或png
           imageDir：另存到的位置，必须以/结尾
           image：需要另存的图片，为UIImage类型
   返回值：是否另存成功，成功返回1，否则返回0
   例子：假设image为一个UIImage，可以通过imageSave(imageName: "1", type: "jpg", imagedir: "/Users/apple/Desktop/", image: image)来将这个图片另存到桌面上，文件名为"1.jpg"
   更改日志：2020/07/23 由刘相廷创建
.**********************************************************************************/
func imageSave(imageName: String, type: String, imageDir: String, image: UIImage?) -> Int {
    if type == "jpg" {
        let dt = imageDir + imageName + ".jpg"
        try? image!.jpegData(compressionQuality: 1)?.write(to: URL(fileURLWithPath: dt))
        return 1
    }
    else if type == "png" {
        let dt = imageDir + imageName + ".png"
        try? image!.pngData()?.write(to: URL(fileURLWithPath: dt))
        return 1
    }
    else {
        return 0
    }
}

// 以下为示例代码，为这三个函数的基本用法
// let base64ImageData = imageDecode(type: "jpg", imageName: "YourImageName")
// let image = imageEncode(base64Data: base64ImageData)
// imageSave(imageName: "1", type: "jpg", imageDir: "/Users/apple/Desktop/", image: image)
// 通过这个方式可以将工程中的"YourImageName.jpg"另存到桌面上

// 说明：为了保证每个客户端都能找到图片文件，最后在需要读写文件的过程中很可能需要使用NSHomeDirectory()来找到不同用户的对应文件夹，此时应使用绝对路径，配合NSHomeDirectory()来查找，而对于像模板这样的事先存储好的图片，则可以使用相对路径来查找
