//
//  RegisterPageViewController.swift
//  OurStory
//
//  Created by Momo on 2020/8/1.
//  Copyright © 2020 Tsinghua ios Club. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if (userEmail != nil) && (userPassword != nil) && (userRepeatPassword != nil)
        {
            if userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty {
                // Display an alert message
                displayMyAlertMessage("All fields are required!")
                return
            }
        } else {
            // Display an alert message
            
            return
        }
        
        // Check if passwords match
        if userPassword! != userRepeatPassword! {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match!")
            return
        }
        
        // Store data
        

        
        // Display alert message with confirmation
        
        
        
    }
    
    func displayMyAlertMessage(_ userMessage: String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        present(self, animated: true, completion: nil)
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
