//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    
    struct Weather: Decodable {
        var location: Location?
        var current: Current?
    }
    
    struct Location: Decodable {
        var name: String
    }
    
    struct Current: Decodable {
        var temp_c: Double
        var condition: Condittion?
    }
    
    struct Condittion: Decodable {
        var text: String
        var icon: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://api.apixu.com/v1/current.json?key=293cadfcdcb0484faff155128192608&q=Gomel"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print(weather)
                DispatchQueue.main.async {
                    self.countryLabel.text = "\(weather.location?.name ?? "")"
                    self.temperatureLabel.text = "\(weather.current?.temp_c ?? 0.0) °C"
                    self.conditionTextLabel.text = "\(weather.current?.condition?.text ?? "")"
                    
                    let iconString = "\(weather.current?.condition?.icon ?? "")"
                    let newIconString = iconString.replacingOccurrences(of: "//", with: "http://")
                    let iconURL = URL(string: newIconString)
                    let iconData = try? Data(contentsOf: iconURL!)
                    self.conditionIcon.image = UIImage(data: iconData!)
                }
            } catch let error {
                print(error)
            }
        }.resume()
        
        
    }
    
}



