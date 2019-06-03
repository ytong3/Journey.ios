//
//  StoryTableViewController.swift
//  Journey
//
//  Created by Aaron Tong on 5/31/19.
//  Copyright © 2019 Aaron Tong. All rights reserved.
//

import UIKit

class StoryTableViewController: UITableViewController {
    
    var stories: [String] = ["one", "two"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "gotoStory", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath)
        cell.textLabel?.text = stories[indexPath.row]
        return cell
    }
    
}
