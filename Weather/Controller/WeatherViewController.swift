//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var inputCityTextField: UITextField!

    let networking = Networking()
    let kindOfWeather = KindOfWeather()
    var city = ""
    var textForShare = ""
    public var arrayForShare: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCityTextField.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        inputCityTextField.layer.borderWidth = 1
        inputCityTextField.alpha = 0.5
        inputCityTextField.layer.cornerRadius = 10
        inputCityTextField.attributedPlaceholder = NSAttributedString(string: "Какой город ищем?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        self.inputCityTextField.delegate = self
        
        networking.getWeather(city: "grodno", completion: { [weak self] weather in
                self?.setValue(from: weather)
        })
        
        inputCityTextField.tintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputCityTextField.becomeFirstResponder()
    }
    
    // Пока не найдено применение
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if inputCityTextField.text?.count == 1 {
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        arrayForShare.removeAll()
        city = inputCityTextField.text!
        networking.getWeather(city: city, completion: { [weak self] weather in
                self?.setValue(from: weather)
        })
        
        self.view.endEditing(true)
        return false
    }
    
    func setValue(from weather: Weather?) {
        if weather?.location == nil || weather?.current == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "CityNotFoundID") as! CityNotFoundViewController
            secondViewController.message = "Не получилось найти\nгород \(city)"
            present(secondViewController, animated: false, completion: nil)
            
            return
        }
        
        cityLabel.text = "\(weather?.location?.name ?? "")"
        temperatureLabel.text = "\(weather?.current?.temp_c ?? 0) °"
        conditionTextLabel.text = "\(weather?.current?.condition?.text ?? "")"
        
        textForShare = "Сейчас в городе \(cityLabel.text ?? "не найден") \(temperatureLabel.text ?? "температура не найдена")"
        arrayForShare.append(textForShare)
        
        // Выбрать GIF
        let gif = kindOfWeather.getKindOfWeather(kind: weather?.current?.condition?.text ?? "")
        weatherImageView.image = UIImage(named: gif)
//        self.weatherImageView.loadGif(name: gif) // Переход на обычные картинки
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: arrayForShare, applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }

}



