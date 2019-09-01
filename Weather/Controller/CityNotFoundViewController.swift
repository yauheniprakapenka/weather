//
//  CityNotFoundViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 31/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class CityNotFoundViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var cityNotFoundLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.layer.cornerRadius = 10
        
        catImageView.loadGif(name: "Cats")
        
        self.cityNotFoundLabel.text = message
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherViewController = storyboard.instantiateViewController(withIdentifier: "MainID") as! WeatherViewController
        self.present(weatherViewController, animated: false, completion: nil)
    }
    

}
