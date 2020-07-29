//
//  MessageSplit.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/27.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//  此文件中定义了用于处理特定格式消息的函数messageSplit
//  消息格式为：类型信息 + [字符串长度 + 字符串]

import Foundation

/***********************************************************************************.
   函数名称：messageSplit
   函数功能：用于处理特定格式消息，将其转化为其中的有效信息
   参数接口：message：处理前的字符串，消息格式为：类型信息 + [字符串长度 + 字符串]
   返回值：处理后的信息数组
   例子：messageSplit("login 5 shawn 10 lxt5393792") = {"shawn","lxt5393792"}
   更改日志：2020/07/28 由刘相廷创建
.**********************************************************************************/
func messageSplit(message:String) -> Array<String>{
    let originMessageLength = message.count // 消息的原始长度
    var i:Int = 0
    while message[i] != " " {
        i += 1
    }// 寻找第一个空格的位置
    let messageLength = originMessageLength - i - 1 // 去除类型信息后的消息长度
    i += 1
    var temp:String = ""
    for _ in 0...messageLength{
        temp.insert(contentsOf:message[i], at: temp.endIndex)
        i += 1
    } // 获取去除类型信息后的信息
    var messageList = [String]() // 要返回的有效信息列表
    while true {
        let num = Int((temp.split(separator: " ")[0] as NSString).intValue) // 获取信息的长度
        i = 0
        while temp[i] != " " {
            i += 1
        } // 找到第一个空格
        temp = temp.substring(fromIndex: i + 1) // temp中去除长度信息
        messageList.append(temp.substring(toIndex: num)) // 向有效信息列表中添加有效信息
        if temp.count == num { // 当有效信息长度等于信息长度时，解析完毕
            return messageList
        }
        else{ // 如果不等于，则说明后面还有未解析的信息
            temp = temp.substring(fromIndex: num + 1) // 取后半段
        }
    }
}
