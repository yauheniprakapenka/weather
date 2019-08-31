//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    let weather = Weather()
    let kindOfWeather = KindOfWeather()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var inputCityFextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCityFextField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputCityFextField.alpha = 0.5
        inputCityFextField.layer.borderWidth = 1
        inputCityFextField.layer.cornerRadius = 10
        inputCityFextField.attributedPlaceholder = NSAttributedString(string: "Введите город", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.inputCityFextField.delegate = self
        
        weather.getWeather(city: "grodno", completion: {
            DispatchQueue.main.async {
                self.setValue()
            }
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let inputCity = inputCityFextField.text!
        weather.getWeather(city: inputCity, completion: {
            DispatchQueue.main.async {
                self.setValue()
            }
        })
        
        self.view.endEditing(true)
        return false
    }
    
    func setValue() {
        self.countryLabel.text = self.weather.country
        self.temperatureLabel.text = self.weather.temperature
        self.conditionTextLabel.text = self.weather.condititon
        
        // Выбрать GIF
        let gif = self.kindOfWeather.getKindOfWeather(kind: self.weather.condititon)
        self.weatherImageView.loadGif(name: gif)
    }

}



