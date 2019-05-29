//
//  FirstViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            appDelegate.window!.rootViewController = StartupViewController.create()
        }
        catch let error as NSError {
            self.showMessagePrompt(message: error.localizedDescription)
        }
    }
    
}

