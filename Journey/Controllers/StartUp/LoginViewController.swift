//
//  LoginViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling
        emailField.borderStyle = .roundedRect
        emailField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: UIControl.Event.editingChanged)
        
        passwordField.borderStyle = .roundedRect
        passwordField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldChangedEventHandler(){
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, password.count>6 else {
            loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            loginButton.isEnabled = false
            
            return
        }
        
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.isEnabled = true
    }
    
    @IBAction func forgetPasswordButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "resetPassword", sender: nil)
    }
}
