//
//  TripViewController.swift
//  Journey
//
//  Created by Yue Tong on 5/29/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import Eureka

class TripViewController : FormViewController{
    var delegate: AddTripsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure the form
        //navigationOptions = .Disabled
        form
            +++ Section()
            <<< TextRow("name") { row in
                row.title = NSLocalizedString("Name", comment: "")
                row.add(rule: RuleRequired())
                }.cellSetup{ cell, row in
                    cell.textField.placeholder = NSLocalizedString("Name", comment: "label")
                }.cellUpdate{ cell, row in
                    if !row.isValid{
                        cell.titleLabel?.textColor = .red
                    }
                }
        
            <<< TextAreaRow("description") {row in
                row.placeholder = NSLocalizedString("Description", comment: "")
                }
        
            +++ Section(NSLocalizedString("Start", comment: "Section header"))
            <<< DateTimeInlineRow("from_date") {row in
                row.title=NSLocalizedString("Date", comment: "label")
                }.onChange {row in
                    if let v=row.value {
                        let r: DateTimeInlineRow? = self.form.rowBy(tag: "to_date")
                        r?.minimumDate = v
                    }
                }
            <<< TextRow("from_place") {row in
                    row.title = NSLocalizedString("Place", comment: "label")
                }
        
            +++ Section(NSLocalizedString("End", comment: "Section header"))
            <<< DateTimeInlineRow("to_date") {row in
                row.title = NSLocalizedString("Date", comment: "label")
                }.onChange{row in
                    if let v = row.value {
                        let r: DateTimeInlineRow? = self.form.rowBy(tag: "from_date")
                        r?.maximumDate = v
                    }
                }
            <<< TextRow("to_place") { row in
                    row.title = NSLocalizedString("Place", comment: "label")
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let errors = form.validate()
        if errors.count>0 {
            print("We've got an error")
            showMessagePrompt(message: "Invalid inputs")
        }
        else{
            let valuesDict = form.values()
            print(valuesDict)
            delegate!.userAddedANewTrip(tripValues: valuesDict)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

protocol AddTripsDelegate {
    func userAddedANewTrip(tripValues: [String: Any?])
}
