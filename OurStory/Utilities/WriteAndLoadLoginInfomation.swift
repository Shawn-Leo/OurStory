//
//  WriteAndLoadLoginInfomation.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/8/4.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//  此文件中写了关于将用户名密码信息写入本地，以及从本地读取的相关操作
//

import Foundation

extension LoginPageViewController{
    /***********************************************************************************.
       函数名称：writeLoginInformation
       函数功能：将用户ID、密码以及“是否记住密码”信息写入本地
       参数接口：ID：用户ID，唯一标识，为utf8String
               Password：用户密码，为utf8String
               rememberPasswordFlag：是否记住密码，整数，0为否，1为是
       返回值：无
       例子：通过LoginPageViewController.writeLoginInformation(ID: "Shawn", Password: "lxt5393792", rememberPasswordFlag: 1) 可以将用户的用户名密码以及“是否记住密码”信息保存到本地便于下次使用
       更改日志：2020/08/04 由刘相廷创建
    .**********************************************************************************/
    static func writeLoginInformation(ID: String, Password: String, rememberPasswordFlag: Int){
        let homeDirectory = NSHomeDirectory() //信息存储主文件夹地址
        let infoDir = homeDirectory + "/Documents/LoginInfo.txt" //将相关信息存在Documents/LoginInfo.txt下
        let fileManager = FileManager.default
        fileManager.createFile(atPath: infoDir, contents: nil, attributes: nil)           // 文件重新写入
        let handle = FileHandle(forWritingAtPath: infoDir)
        if rememberPasswordFlag == 1{
            // 如果用户选择记住密码，则把1 用户名 密码写入文件中
            handle?.write(("1\n" + ID + "\n").data(using: String.Encoding.utf8)!)
            handle?.write(Password.data(using: String.Encoding.utf8)!)
        }
        else{
            // 如果用户选择不记住密码，密码写为Nil
            handle?.write(("0\n" + ID + "\nNil").data(using: String.Encoding.utf8)!)
        }
    }
    
    /***********************************************************************************.
       函数名称：loadLoginInformation
       函数功能：读取存储在本地的用户ID、密码以及“是否记住密码”信息
       参数接口：ID：用户ID，唯一标识，为utf8String
               Password：用户密码，为utf8String
               rememberPasswordFlag：是否记住密码，整数，0为否，1为是
       返回值：无
       例子：LoginPageViewController.loadLoginInformation(ID: &ID, Password: &Password, rememberPasswordFlag: &flag)
       通过这个方式可以为ID，Password和flag三个变量赋值，便于显示到界面上
       更改日志：2020/08/04 由刘相廷创建
       备注：具体使用时，无论用户是否选择“记住密码”都可以使用这个函数，若用户没有选择记住密码，你的Password会被赋值为空字符串，直接将其设置为密码栏初始文本即可
    .**********************************************************************************/
    static func loadLoginInformation(ID: inout String, Password: inout String, rememberPasswordFlag: inout Int){
        let homeDirectory = NSHomeDirectory() //信息存储主文件夹地址
        let infoDir = homeDirectory + "/Documents/LoginInfo.txt"
        //将相关信息存在Documents/LoginInfo.txt下
        do{
            let text = try String(contentsOfFile: infoDir) // 将文件中的所有文本读出
            rememberPasswordFlag = String(text.split(separator: "\n")[0]).toInt()         // 分割后得到的第一个数字为“是否记住密码的flag
            if rememberPasswordFlag == 1 {
                // 如果此前用户选择了”记住密码“，则再次登录时直接显示用户名和密码，将用户名和密码赋值给ID和Password
                ID = String(text.split(separator: "\n")[1])
                Password = String(text.split(separator: "\n")[2])
            }
            else{
                // 如果用户没有选择记住密码，则再次登录时只显示用户名，密码栏为空
                ID = String(text.split(separator: "\n")[1])
                Password = ""
            }
        }catch{
            print(error)
        }
    }
}


//用法：
//    LoginPageViewController.writeLoginInformation(ID: "Shawn", Password: "lxt5393792", rememberPasswordFlag: 1) // 这样可以将用户的用户名密码以及“是否记住密码”信息保存到本地便于下次使用
//
//    var ID: String = ""
//    var Password: String = ""
//    var flag:Int = 0
//    LoginPageViewController.loadLoginInformation(ID: &ID, Password: &Password, rememberPasswordFlag: &flag)
//通过这个方式可以为ID，Password和flag三个变量赋值，便于显示到界面上
