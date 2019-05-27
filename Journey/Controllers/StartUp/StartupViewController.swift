//
//  StartupViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class StartupViewController: UIViewController{
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
                        
            if (user != nil){
                appDelegate.window?.rootViewController = MainViewController.create()
            }
            else {
                if(UserDefaults.isAppAlreadyLaunchedOnce()){
                    self.performSegue(withIdentifier: "login", sender: nil)
                }
                else{
                    self.performSegue(withIdentifier: "register", sender: nil)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    class func create() -> StartupViewController? {
        let sb = UIStoryboard(name:"Startup", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "StartupViewController") as! StartupViewController
        
        return vc
    }
}
