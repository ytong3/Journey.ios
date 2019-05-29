//
//  ForgetPasswordViewController.swift
//  Journey
//
//  Created by Yue Tong on 5/28/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgetPasswordViewController : UIViewController{
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // styling
        emailField.borderStyle = .roundedRect
        emailField.addTarget(self, action: #selector(RegisterViewController.textFieldChangedEventHandler), for: UIControl.Event.editingChanged)
    }
    
    
    @IBAction func resetPasswordButtonPressed(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty else{
            showMessagePrompt(message: "Email cannot be empty")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) {
            error in
            if let error = error {
                self.showMessagePrompt(message: error.localizedDescription)
                return
            }
            
            self.showMessagePrompt(message: "Passowrd reset has been sent to the email.")
        }
    }
    
    @objc func textFieldChangedEventHandler(){
        guard let email = emailField.text, !email.isEmpty else {
            resetPasswordButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            resetPasswordButton.isEnabled = false
            
            return
        }
        
        resetPasswordButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        resetPasswordButton.isEnabled = true
    }
}
