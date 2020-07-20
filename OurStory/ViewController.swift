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
        var request = URLRequest(url: URL(string: "ws://192.168.31.88:4396/")!) //此为服务器的ip和端口信息，目前暂时以魔法值存储
        request.timeoutInterval = 5
        socket = WebSocket(request: request) //创建了一个socket变量
        socket.delegate = self
        socket.connect()  //连接到服务器
    }

    
    //析构函数
    deinit {
      socket.disconnect()
      socket.delegate = nil
    }

}
