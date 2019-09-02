//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bearImageView: UIImageView!
    
    
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var inputCityTextField: UITextField!
    
    let weather = Networking()
    let kindOfWeather = KindOfWeather()
    var inputCity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCityTextField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        inputCityTextField.alpha = 0.5
        inputCityTextField.layer.borderWidth = 1
        inputCityTextField.layer.cornerRadius = 10
        inputCityTextField.attributedPlaceholder = NSAttributedString(string: "Какой город ищем?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.inputCityTextField.delegate = self
        
        weather.getWeather(city: "grodno", completion: {
            DispatchQueue.main.async {
                self.setValue()
            }
        })
        
//        bearImageView.image = UIImage(named: "shy")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputCityTextField.becomeFirstResponder()
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if inputCityTextField.text?.count == 1 {
            bearImageView.image = UIImage(named: "active")
        } else if inputCityTextField.text?.count == 2 {
            bearImageView.image = UIImage(named: "shy")
        } else if inputCityTextField.text?.count == 3 {
            bearImageView.image = UIImage(named: "ecstatic")
        } else if inputCityTextField.text?.count == 4 {
            bearImageView.image = UIImage(named: "neutral")
        } else if inputCityTextField.text?.count == 5 {
            bearImageView.image = UIImage(named: "peek")
        }
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputCity = inputCityTextField.text!
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
        
        if gif == "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "CityNotFoundID") as! CityNotFoundViewController
            secondViewController.message = "Не получилось найти\nгород \(inputCity)"
            self.present(secondViewController, animated: false, completion: nil)
        } else {
            self.weatherImageView.loadGif(name: gif)
        }
    }

}



