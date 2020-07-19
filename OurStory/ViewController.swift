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

class ViewController: UIViewController, WebSocketDelegate {
    

    var socket: WebSocket!  //这个变量即为WebSocket的关键变量
    var isConnected = false
    let server = WebSocketServer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://echo.websocket.org
        var request = URLRequest(url: URL(string: "ws://192.168.31.88:4396/")!) //此为服务器的ip和端口信息，目前暂时以魔法值存在
        request.timeoutInterval = 5
        socket = WebSocket(request: request) //创建了一个socket变量
        socket.delegate = self
        socket.connect()  //连接到服务器
    }

    // MARK: - WebSocketDelegate
    /**************************************************************************************
     .
        函数名称：didReceive
        函数功能：描述客户端收到各类信息时的处理方式
        参数接口：使用协议默认参数，我们无需修改
        返回值：无
        例子：当客户端连接到服务器时，收到一个.connected信息，触发相关case，向控制台输出"websocket is connected:             \(headers)"，向服务器发送“Hi Server"
        更改日志：2020/07/16 由刘相廷创建，并添加连接成功时向服务器发信的功能
        备注：此函数参考了starscream的自带demo
     .
     **************************************************************************************/
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        /*.当客户端连接到服务器时，收到一个.connected信息，触发相关case，向控制台输出"websocket is connected:\(headers)"，向服务器发送“Hi Server".*/
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
            socket.write(string: "Hi Server")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
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
    
    //析构函数
    deinit {
      socket.disconnect()
      socket.delegate = nil
    }

}
