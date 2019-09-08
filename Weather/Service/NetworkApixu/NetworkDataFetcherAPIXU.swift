//
//  apixu.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 08/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

class NetworkDataFetcherAPIXU {
    
        func fetchWeather(city: String, completion: @escaping (_ weather: SearchApixuResults?) -> Void) {
            let urlString = "http://api.apixu.com/v1/current.json?key=293cadfcdcb0484faff155128192608&q=\(city)"
            guard let url = URL(string: urlString) else { return }
    
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard error == nil else { return }
    
                do {
                    let weather = try JSONDecoder().decode(SearchApixuResults.self, from: data)
                    print(weather)
                    DispatchQueue.main.async {
                        completion(weather)
                    }
                } catch let error { print(error) }
            }.resume()
        }
    
}
