//
//  SocketIOManager.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/8/3.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//  此文件用于剥离socket变量和界面的关联
//

import Foundation
import Starscream

class SocketIOManager: WebSocketDelegate
{
    static var shareInstance:SocketIOManager!
    var socket: WebSocket!  // 这个变量即为WebSocket的关键变量
    var isConnected = false
    var connectionIndex:Int = -1
    let dateformatter = DateFormatter()
    
    func socketConnect(){
        var request = URLRequest(url: URL(string: "ws://182.92.217.15:80/")!)
        // 此为服务器的ip和端口信息，目前暂时以魔法值存储
        request.timeoutInterval = 5
        SocketIOManager.shareInstance.socket = WebSocket(request: request) // 创建了一个socket变量
        SocketIOManager.shareInstance.socket.delegate = self
        SocketIOManager.shareInstance.socket.connect()  // 连接到服务器
        
    }
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
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
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
    
    // 错误处理函数，直接拷贝了starscream中demo的写法，不必修改
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
        }
        else if type == "LoginStatus"{
            AuthViewController.loginStatus = messageSplit(message: message)[0].toInt();
        }
        else if type == "RegisterStatus"{
            AuthViewController.registerStatus = messageSplit(message: message)[0].toInt();
            
        }
    }
    
    
    
}
