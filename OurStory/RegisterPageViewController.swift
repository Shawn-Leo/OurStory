//
//  RegisterPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/1.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class RegisterPageViewController: AuthViewController {


    @IBOutlet weak var userIdentifierTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
        
        // Display notification message with confirmation
//        let myAlert = UIAlertController(title: "", message: "Registration is successful. Thank you!", preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
//            action in
//            self.dismiss(animated: true, completion: nil)
//        }
//        myAlert.addAction(okAction)
//        present(myAlert, animated: true, completion: nil)
        
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
