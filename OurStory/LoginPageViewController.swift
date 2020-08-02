//
//  LoginPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/2.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class LoginPageViewController: AuthViewController {

    
    @IBOutlet weak var userIdentifierTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
        
        // Do login
        login(ID: userIdentifier!, password: userPassword!)
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
