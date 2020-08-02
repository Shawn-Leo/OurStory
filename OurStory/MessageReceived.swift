//
//  MessageReceived.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/20.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import Foundation
import Starscream

extension AuthViewController {
   // MARK: - WebSocketDelegate
    /**************************************************************************************.
        函数名称：didReceive
        函数功能：描述客户端收到各类信息时的处理方式
        参数接口：使用协议默认参数，我们无需修改
        返回值：无
        例子：当客户端连接到服务器时，收到一个.connected信息，触发相关case，向控制台输出"websocket is connected:             \(headers)"，向服务器发送“Hi Server"
        更改日志：2020/07/16 由刘相廷创建，并添加连接成功时向服务器发信的功能
        备注：此函数参考了starscream的自带demo
     .**************************************************************************************/
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            messageHandle(message: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    //错误处理函数，直接拷贝了starscream中demo的写法，不必修改
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    func messageHandle(message: String){
        let type = message.split(separator: " ")[0]
        if type == "ConnectionIndex"{
            connectionIndex = messageSplit(message: message)[0].toInt()
            register(ID: "H1234", password: "123456", name: "胡之阳")
        }
        else if type == "LoginStatus"{
            // 此处请俊鹏同学续写啦～
            // 经过split之后会得到几个信息，首先是一个数字，如果数字为1则代表登陆成功，此时还会附带用户名
            // 若数字为2，说明用户名不存在，若数字为0，说明用户名存在但密码不正确
        }
        else if type == "RegisterStatus"{
            // 此处请俊鹏同学续写啦～
            // 经过split之后会得到一个数字，如果数字为1则代表登陆成功，若数字为0，说明用户名已被注册
            // 在编写界面的时候，请直接把类似于“两次密码不一样”“密码太短”等不依赖网络的情况扼杀在传输之前
        }
    }
}
