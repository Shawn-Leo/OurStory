//
//  RegisterPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/1.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    static var registerStatus:Int = -1{
        didSet {
            // 在这里写上registerStatus改变时的函数
            // 0代表ID重复，1代表成功注册
            if let rvc = UIViewController.currentViewController() as? RegisterPageViewController {
                switch registerStatus {
                case 0:
                    rvc.displayMyAlertMessage("Alert", " This identifier has been registered!")
                case 1:
                    let myAlert = UIAlertController(title: "", message: "Register successfully！", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                        action in
                        rvc.dismiss(animated: true, completion: nil)
                    }
                    myAlert.addAction(okAction)
                    rvc.present(myAlert, animated: true, completion: nil)
                default:
                    break
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var userIdentifierTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userIdentifier = userIdentifierTextField.text
        let userName = userNameTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if (userName != nil) && (userPassword != nil) && (userRepeatPassword != nil) && (userIdentifier != nil) {
            if userName!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty || userIdentifier!.isEmpty
            {
                // Display an alert message
                displayMyAlertMessage("Alert", "All fields are required!")
                return
            }
        } else {
            print("Register page alert: nil is produced!")
            return
        }
        
        // Check if passwords match
        if userPassword! != userRepeatPassword! {
            // Display an alert message
            displayMyAlertMessage("Alert", "Passwords do not match!")
            return
        }
        
        // Do registration
        register(ID: userIdentifier!, password: userPassword!, name: userName!)
        
        
    }
    
    
    // 提示信息显示函数, ok按键不作任何处理
    func displayMyAlertMessage(_ title: String,_ userMessage: String) {
        
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        
        present(myAlert, animated: true, completion: nil)
    }
    
    func register(ID:String, password: String, name: String){
        let time = SocketIOManager.sharedInstance.dateformatter.string(from: Date())
        SocketIOManager.sharedInstance.socket.write(string: "Register " + String(ID.count) + " " + ID + " " + String(password.count) + " " + password + " " + String(name.count) + " " + name + " " + String(String(SocketIOManager.sharedInstance.connectionIndex).count) +  " " + String(SocketIOManager.sharedInstance.connectionIndex) + " " + "19 " + time)
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
