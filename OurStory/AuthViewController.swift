//
//  ViewController.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/14.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//  文档中参考了https://github.com/daltoniam/starscream的simple test demo，特此鸣谢
//

import UIKit
import Starscream

class AuthViewController: UIViewController {
    let dateformatter = DateFormatter()
    static var loginStatus:Int = -1 {
        didSet(incomeLoginStatus){
            // 在这里写上loginStatus改变时的函数
            // 0代表密码错误，1代表成功登陆，2代表用户名不存在
        }
    }
    static var registerStatus:Int = -1{
        didSet(incomeRegisterStatus){
            // 在这里写上registerStatus改变时的函数
            // 0代表ID重复，1代表成功注册
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // https://echo.websocket.org
        SocketIOManager.shareInstance.socketConnect()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
        
    }
    
    func register(ID:String, password: String, name: String){
        let time = self.dateformatter.string(from: Date())
        SocketIOManager.shareInstance.socket.write(string: "Register " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(name.count) + " " + name + " " + String(String(SocketIOManager.shareInstance.connectionIndex).count) +  " " + String(SocketIOManager.shareInstance.connectionIndex) + " " + "19 " + time)
    }
    
    func login(ID:String, password: String){
        let time = self.dateformatter.string(from: Date())
        SocketIOManager.shareInstance.socket.write(string: "Login " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(String(SocketIOManager.shareInstance.connectionIndex).count) +  " " + String(SocketIOManager.shareInstance.connectionIndex) + " " + "19 " + time)
    }
    
    // 提示信息显示函数, ok按键不作任何处理
    func displayMyAlertMessage(_ title: String,_ userMessage: String) {
        
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    // 析构函数
    deinit {
      SocketIOManager.shareInstance.socket.disconnect()
      SocketIOManager.shareInstance.socket.delegate = nil
    }

}
