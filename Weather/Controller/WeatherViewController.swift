//
//  ViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit
import Lottie

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionTextLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var unsplashImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var womanWithUmbrella: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var showPhotoButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    @IBOutlet weak var backgroundButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var womanWithUmbrellaTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var womanWithUmbrellaLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var lottieView: AnimationView!
    
    let networkDataFetcherAPIXU = NetworkServiceApixu()
    let networkDataFetcherUnsplash = NetworkDataFetcherUnsplash()

    let kindOfWeather = TypeOfWeather()
    let motionEffect = MotionEffect()
    
    var city = "London"
    var imageFromUnsplashURL = ""
    var arrayForShareWithImage: [UIImage] = []
    var imageIsShow = false
    var weatherSearchHistory = [String]()
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkDataFetcherAPIXU.getData(city: "London", completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        
        shareButton.layer.cornerRadius = 10
        showPhotoButton.layer.cornerRadius = 10
        historyButton.layer.cornerRadius = 10
        
        unsplashImageView.alpha = 0
        
        backgroundButtonConstraint.constant = (screenSize.height / 1.9) - 50
        
        self.cityTextField.delegate = self
        self.hideKeyboard()
        
        addCustomActivityIndicator()
        
        createGradient()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.motionEffect.applyParallax(toView: self.womanWithUmbrella, magnitude: 60)
        }
    }
    
    @IBAction func showPhotoButtonTapped(_ sender: UIButton) {
        imageIsShow = !imageIsShow
        
        if imageIsShow {
            UIImageView.animate(withDuration: 1.5) {
                self.womanWithUmbrellaTrailingConstraint.constant = CGFloat(-55 - ((28 * self.screenSize.width) / 100))
                self.womanWithUmbrellaLeadingConstraint.constant = CGFloat(163 + ((28 * self.screenSize.width) / 100))
                self.view.layoutIfNeeded()
            }
            
            downloadUnsplashPhoto()
            
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
        
        weatherSearchHistory.append(cityTextField.text!)
        
        if imageIsShow {
            startCustomActivityIndicator()
        }
        
        city = cityTextField.text!
        
        downloadUnsplashPhoto()
        
        networkDataFetcherAPIXU.getData(city: city, completion: { [weak self] weather in
            self?.setValue(from: weather)
        })
        self.view.endEditing(true)
        
        return false
    }
    
    fileprivate func startCustomActivityIndicator() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.27, repeats: false, block: { (finished) in
            self.lottieView.alpha = 1
            self.loadingLabel.alpha = 1
            self.lottieView.play { (finished) in
                UIView.animate(withDuration: 0.2) {
                    self.lottieView.alpha = 0
                    self.loadingLabel.alpha = 0
                }
            }
        })
    }
    
    func downloadUnsplashPhoto() {
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
    
    func setValue(from weather: SearchApixuResults?) {
        if weather?.location == nil || weather?.current == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let cityNotFoundViewController = storyboard.instantiateViewController(withIdentifier: "CityNotFoundViewControllerID") as! CityNotFoundViewController
            cityNotFoundViewController.message = "Не получилось найти\nгород \(city)"
            present(cityNotFoundViewController, animated: false, completion: nil)
            
            return
        }
        
        cityLabel.text = "\(weather?.location?.name ?? "")"
        temperatureLabel.text = "\(weather?.current?.temp_c ?? 0)°"
        conditionTextLabel.text = "\(weather?.current?.condition?.text ?? "")"
        
        let gif = kindOfWeather.fetchTypeOfWeather(kind: weather?.current?.condition?.text ?? "")
        weatherImageView.image = UIImage(named: gif)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let tableVC = navVC.viewControllers.first as! HistoryTableViewController
        tableVC.historyItem = weatherSearchHistory
    }
    
    func addCustomActivityIndicator() {
        lottieView.loopMode = .playOnce
        lottieView.animation = Animation.named("1173-sun-burst-weather-icon")
        lottieView.animationSpeed = 1.8
        lottieView.contentMode = .scaleAspectFill
        lottieView.layer.cornerRadius = 13
        lottieView.alpha = 0
        loadingLabel.alpha = 0
    }
    
    fileprivate func createGradient() {
        let myNewView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height / 1.7))
        myNewView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        gradientView.addSubview(myNewView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = myNewView.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9663092494, green: 0.9565795064, blue: 0.9565963149, alpha: 0).cgColor]
        myNewView.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "HistoryVCSeque", sender: self)
    }
    
}



