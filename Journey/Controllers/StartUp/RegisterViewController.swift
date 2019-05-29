//
//  RegisterViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var waitSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling
        usernameField.borderStyle = .roundedRect
        usernameField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: .editingChanged)
        
        emailField.borderStyle = .roundedRect
        emailField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: UIControl.Event.editingChanged)
        
        passwordField.borderStyle = .roundedRect
        passwordField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let name = usernameField.text, !name.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                self.showMessagePrompt(message: "Username/email/password cannot be empty")
                return
        }
        
        waitSpinner.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password){
            (authResult, error) in
            self.waitSpinner.stopAnimating()
            
            if let error = error {
                self.showMessagePrompt(message: error.localizedDescription)
                return
            }
            
            //goto the MainView controller
            appDelegate.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK - Input Validation
    
    @objc func textFieldChangedEventHandler() {
        guard let name = usernameField.text, !name.isEmpty, let email = emailField.text, !email.isEmpty, let password = passwordField.text, password.count>6 else {
            registerButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            registerButton.isEnabled = false
            
            return
        }
        
        registerButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        registerButton.isEnabled = true
    }
}
