//
//  ParseJSON.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 30/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class Weather {
    
    struct Weather: Decodable {
        var location: Location?
        var current: Current?
    }
    
    struct Location: Decodable {
        var name: String
    }
    
    struct Current: Decodable {
        var temp_c: Int
        var condition: Condition?
        var is_day: Int
    }
    
    struct Condition: Decodable {
        var text: String
        var icon: String
        var code: Int
    }
    
    public var country = ""
    public var temperature = ""
    public var condititon = ""
    
    func getWeather(city: String, completion: @escaping () -> Void) {
        let urlString = "http://api.apixu.com/v1/current.json?key=293cadfcdcb0484faff155128192608&q=\(city)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print(weather)
                completion()
                    self.country = "\(weather.location?.name ?? "")"
                    self.temperature = "\(weather.current?.temp_c ?? 0) °C"
                    self.condititon = "\(weather.current?.condition?.text ?? "")"
            } catch let error { print(error) }
        }.resume()
    }
    
}
