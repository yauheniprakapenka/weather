//
//  HistoryTableViewController.swift
//  Weather
//
//  Created by yauheni prakapenka on 18/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var cityNameItem = [String]()
    var imageItem = [UIImage]()
    var dateItem = [String]()
    var temperatureItem = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNameItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CustomTableViewCell
        
        cell.cityImage?.image = imageItem[indexPath.row]
        cell.cityImage?.layer.cornerRadius = cell.cityImage.frame.size.height / 2
        cell.cityImage?.clipsToBounds = true
        
        cell.cityNameLabel?.text = cityNameItem[indexPath.row]
        cell.citySearchDateLabel.text = dateItem[indexPath.row]
        cell.cityTemperatureLabel.text = temperatureItem[indexPath.row]
        
        return cell
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

