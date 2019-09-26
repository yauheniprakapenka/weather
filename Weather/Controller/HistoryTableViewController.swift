//
//  HistoryTableViewController.swift
//  Weather
//
//  Created by yauheni prakapenka on 18/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var historyItem = [String]()
    var imageItem = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = historyItem[indexPath.row]
        cell.imageView?.image = imageItem[indexPath.row]
        return cell
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

