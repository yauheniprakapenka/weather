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
    
    let networking = Networking()
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
        
        networking.getWeather(city: "grodno", completion: { [weak self] weather in
                self?.setValue(from: weather)
        })
        
        inputCityTextField.tintColor = .white
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
        networking.getWeather(city: inputCity, completion: { [weak self] weather in
                self?.setValue(from: weather)
        })
        
        self.view.endEditing(true)
        return false
    }
    
    func setValue(from weather: Weather?) {
        if weather?.location == nil || weather?.current == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "CityNotFoundID") as! CityNotFoundViewController
            secondViewController.message = "Не получилось найти\nгород \(inputCity)"
            self.present(secondViewController, animated: false, completion: nil)
            
            return
        }
        
        self.countryLabel.text = "\(weather?.location?.name ?? "")"
        self.temperatureLabel.text = "\(weather?.current?.temp_c ?? 0) °C"
        self.conditionTextLabel.text = "\(weather?.current?.condition?.text ?? "")"
        
        // Выбрать GIF
        let gif = self.kindOfWeather.getKindOfWeather(kind: weather?.current?.condition?.text ?? "")
        
        self.weatherImageView.loadGif(name: gif)
    }

}



