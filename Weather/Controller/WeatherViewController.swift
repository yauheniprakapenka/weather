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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var womanWithUmbrella: UIImageView!
    
    let networkService = NetworkService() // Удалить
    let networkDataFetcher = NetworkDataFetcher()
    let kindOfWeather = KindOfWeather()
    let motionEffect = MotionEffect()
    
    var city = ""
    var arrayForShareWithImage: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getWeather(city: "grodno", completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        
        shareButton.layer.cornerRadius = 15
        
        self.cityTextField.delegate = self
        self.hideKeyboard()
        
        motionEffect.applyParallax(toView: womanWithUmbrella, magnitude: 60)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        city = cityTextField.text!
        networkService.getWeather(city: city, completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        self.view.endEditing(true)
        
        networkDataFetcher.fetchImages(searchTerm: "cloud") { (searchResults) in
            searchResults?.results.map({ (photo) in
                print(photo.urls["small"])
            })
            
        }
        
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
        temperatureLabel.text = "\(weather?.current?.temp_c ?? 0)°"
        conditionTextLabel.text = "\(weather?.current?.condition?.text ?? "")"

        let gif = kindOfWeather.getKindOfWeather(kind: weather?.current?.condition?.text ?? "")
        weatherImageView.image = UIImage(named: gif)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let image = takeScreenshot()
        arrayForShareWithImage.removeAll()
        arrayForShareWithImage.append(image)
        
        let shareController = UIActivityViewController(activityItems: arrayForShareWithImage, applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    func takeScreenshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        return image
    }

}



