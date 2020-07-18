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
        var request = URLRequest(url: URL(string: "ws://192.168.31.88:4396/")!) //https://localhost:8080
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }

    // MARK: - WebSocketDelegate
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
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
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    deinit {
      socket.disconnect()
      socket.delegate = nil
    }

}

