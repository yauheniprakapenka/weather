//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController, UITextFieldDelegate {
    
    let weather = Weather()
    let conditionWeatherJSON = ConditionWeatherJSON()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    @IBOutlet weak var inputCityFextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCityFextField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputCityFextField.alpha = 0.5
        inputCityFextField.layer.borderWidth = 1
        inputCityFextField.layer.cornerRadius = 15
        inputCityFextField.attributedPlaceholder = NSAttributedString(string: "Введите город", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        weatherImageView.loadGif(name: "Sunny")
        
        self.inputCityFextField.delegate = self
        
        conditionWeatherJSON.getCondition()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let inputCity = inputCityFextField.text!
        weather.getWeather(city: inputCity, completion: {
            DispatchQueue.main.async {
                self.countryLabel.text = self.weather.country
                self.temperatureLabel.text = self.weather.temperature
                self.conditionTextLabel.text = self.weather.condititon
            }
        })
        
        self.view.endEditing(true)
        return false
    }

}



