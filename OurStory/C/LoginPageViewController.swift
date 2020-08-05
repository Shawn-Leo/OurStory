//
//  LoginPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/2.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    static var isAuthenticated = false
    static var loginStatus:Int = -1 {
        didSet(oldLoginStatus){
            // - 在这里写上loginStatus改变时的函数
            // - 0代表密码错误，1代表成功登陆，2代表用户名不存在,-1代表登出状态
            if isAuthenticated == false {
                // - 如果尚未登陆
                if let lvc = UIViewController.currentViewController() as? LoginPageViewController {
                    switch loginStatus {
                    case 0:
                        lvc.displayMyAlertMessage("Alert", "Incorrect password!")
                    case 1:
                        // lvc.displayMyAlertMessage("Notification", "Login successfully!")
                        self.isAuthenticated = true
                        lvc.performSegue(withIdentifier: "LoginToHome", sender: nil)
                    case 2:
                        lvc.displayMyAlertMessage("Alert", "The identifier do not exist!")
                    default:
                        break
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var userIdentifierTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!

    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userIdentifier = userIdentifierTextField.text
        let userPassword = userPasswordTextField.text
        
        // Check for empty fields
        if (userIdentifier != nil) && (userPassword != nil) {
            if userIdentifier!.isEmpty || userPassword!.isEmpty {
                // Display an alert message
                displayMyAlertMessage("Alert", "All fields are required!")
                return
            }
        } else {
            print("Login page alert: nil is produced!")
            return
        }
        
        // Do login and give response
        login(ID: userIdentifier!, password: userPassword!)
        
    }
    
    
    // - 提示信息显示函数, ok按键不作任何处理
    func displayMyAlertMessage(_ title: String,_ userMessage: String) {
        
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    func login(ID:String, password: String){
        let time = SocketIOManager.sharedInstance.dateformatter.string(from: Date())
        SocketIOManager.sharedInstance.socket.write(string: "Login " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(String(SocketIOManager.sharedInstance.connectionIndex).count) +  " " + String(SocketIOManager.sharedInstance.connectionIndex) + " " + "19 " + time)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
