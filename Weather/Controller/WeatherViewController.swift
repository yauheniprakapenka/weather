//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var unsplashImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var womanWithUmbrella: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var showPhotoButton: UIButton!
    
    @IBOutlet weak var womanWithUmbrellaTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var womanWithUmbrellaLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundButtonConstraint: NSLayoutConstraint!
    
    let networkDataFetcherAPIXU = NetworkDataFetcherAPIXU()
    let networkDataFetcherUnsplash = NetworkDataFetcherUnsplash()

    let kindOfWeather = TypeOfWeather()
    let motionEffect = MotionEffect()
    
    var city = "London"
    var imageFromUnsplashURL = ""
    var arrayForShareWithImage: [UIImage] = []
    var imageIsShow = false
    
    let bound: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkDataFetcherAPIXU.fetchWeather(city: "London", completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        
        shareButton.layer.cornerRadius = 15
        showPhotoButton.layer.cornerRadius = 15
        
        unsplashImageView.alpha = 0
        
        backgroundButtonConstraint.constant = (bound.height / 1.9) - 50
        
        self.cityTextField.delegate = self
        self.hideKeyboard()
        
        motionEffect.applyParallax(toView: womanWithUmbrella, magnitude: 60)
    }
    
    func setValue(from weather: SearchApixuResults?) {
        if weather?.location == nil || weather?.current == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "CityNotFoundViewControllerID") as! CityNotFoundViewController
            secondViewController.message = "Не получилось найти\nгород \(city)"
            present(secondViewController, animated: false, completion: nil)
            
            return
        }
        
        cityLabel.text = "\(weather?.location?.name ?? "")"
        temperatureLabel.text = "\(weather?.current?.temp_c ?? 0)°"
        conditionTextLabel.text = "\(weather?.current?.condition?.text ?? "")"

        let gif = kindOfWeather.fetchTypeOfWeather(kind: weather?.current?.condition?.text ?? "")
        weatherImageView.image = UIImage(named: gif)
    }
    
    @IBAction func showPhotoButtonTapped(_ sender: UIButton) {
        imageIsShow = !imageIsShow
        
        if imageIsShow {
            UIImageView.animate(withDuration: 1.5) {
                self.womanWithUmbrellaTrailingConstraint.constant = CGFloat(-55 - ((28 * self.bound.width) / 100))
                self.womanWithUmbrellaLeadingConstraint.constant = CGFloat(163 + ((28 * self.bound.width) / 100))
                self.view.layoutIfNeeded()
            }
            
            fetchUnsplashPhoto()
            
            UIImageView.animate(withDuration: 0.5, animations: {
                self.unsplashImageView.alpha = 1
            }) { _ in
                self.showPhotoButton.setTitle("Скрыть фото", for: .normal)
            }
        } else {
            UIImageView.animate(withDuration: 1.5) {
                self.womanWithUmbrellaTrailingConstraint.constant = -55
                self.womanWithUmbrellaLeadingConstraint.constant = 163
                self.view.layoutIfNeeded()
            }
            
            UIImageView.animate(withDuration: 0.5, animations: {
                self.unsplashImageView.alpha = 0
            }) { _ in
                self.showPhotoButton.setTitle("Показать фото", for: .normal)
            }
        }
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
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        city = cityTextField.text!
        
        fetchUnsplashPhoto()
        
        networkDataFetcherAPIXU.fetchWeather(city: city, completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        self.view.endEditing(true)
        
        return false
    }
    
    func fetchUnsplashPhoto() {
        networkDataFetcherUnsplash.downloadImage(searchTerm: city) { (searchResults) in
            searchResults?.results.map({ (photo) in
                let url = URL(string: "\(photo.urls["full"]!)")
                let data = try? Data(contentsOf: url!)
                print(photo.urls["full"]!)
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.unsplashImageView.image = image
                }
            })
        }
    }

}



