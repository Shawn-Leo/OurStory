//
//  Register.swift
//  OurStory
//
//  Created by Shawn Leo on 2020/7/28.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import Foundation

extension ViewController{
    func register(ID:String, password: String, name: String){
        let time = self.dateformatter.string(from: Date())
        socket.write(string: "Register " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(name.count) + " " + name + " " + String(String(connectionIndex).count) +  " " + String(connectionIndex) + " " + "19 " + time)
    }
}
