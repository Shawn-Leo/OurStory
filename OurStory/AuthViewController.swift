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

class AuthViewController: UIViewController, WebSocketDelegate {
    var socket: WebSocket!  // 这个变量即为WebSocket的关键变量
    var isConnected = false
    let server = WebSocketServer()
    let textfield = UITextField()
    var connectionIndex:Int = -1
    let dateformatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // https://echo.websocket.org
        var request = URLRequest(url: URL(string: "ws://182.92.217.15:80/")!)
        // 此为服务器的ip和端口信息，目前暂时以魔法值存储
        request.timeoutInterval = 5
        socket = WebSocket(request: request) // 创建了一个socket变量
        socket.delegate = self
        socket.connect()  // 连接到服务器
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
        let list = messageSplit(message: "login 5 shawn 10 lxt5393792")
        for word in list{
            print(word)
        }
    }
    
    func register(ID:String, password: String, name: String){
        let time = self.dateformatter.string(from: Date())
        socket.write(string: "Register " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(name.count) + " " + name + " " + String(String(connectionIndex).count) +  " " + String(connectionIndex) + " " + "19 " + time)
    }
    
    func login(ID:String, password: String){
        let time = self.dateformatter.string(from: Date())
        socket.write(string: "Login " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(String(connectionIndex).count) +  " " + String(connectionIndex) + " " + "19 " + time)
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
      socket.disconnect()
      socket.delegate = nil
    }

}
