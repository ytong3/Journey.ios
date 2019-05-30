//
//  TropsTableViewController.swift
//  Journey
//
//  Created by Yue Tong on 5/29/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit
import UIEmptyState

class TripsTableViewController : UITableViewController{
    let trips: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        self.reloadEmptyState()
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be released
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripsTripCell", for: indexPath) as! TripsTripTableViewCell
        
        cell.name.text = self.trips[indexPath.row]
        
        return cell
        // configure the cell ..
    }
}


//MARK: UIEmptyState data source

extension TripsTableViewController: UIEmptyStateDataSource{
    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: NSLocalizedString("No trips yet", comment: "Empty state"), attributes: attrs)
    }
    
    var emptyStateButtonTitle: NSAttributedString? {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.white,
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        return NSAttributedString(string: NSLocalizedString("Create your first trip", comment: "Empty action"), attributes: attrs)
    }
    
    var emptyStateButtonSize: CGSize? {
        return CGSize(width: 200, height: 40)
    }
}

extension TripsTableViewController: UIEmptyStateDelegate{
    func emptyStateViewWillShow(view: UIView) {
        guard let emptyView = view as? UIEmptyStateView else {return}
        
        emptyView.button.layer.cornerRadius = 5
        emptyView.button.layer.borderWidth = 1
        emptyView.button.layer.borderColor = UIColor.red.cgColor
        emptyView.button.layer.backgroundColor = UIColor.red.cgColor
    }
    
    func emptyStatebuttonWasTapped(button: UIButton) {
        print("Button clicked, take action")
        
        performSegue(withIdentifier: "addTrip", sender: nil)
    }
}
