//
//  UserDefaultsExtention.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func isAppAlreadyLaunchedOnce() -> Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}
