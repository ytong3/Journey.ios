//
//  UIViewControllerExtensions.swift
//  Journey
//
//  Created by Aaron Tong on 5/27/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//
import UIKit

extension UIViewController {
    func showMessagePrompt(message: String?){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
