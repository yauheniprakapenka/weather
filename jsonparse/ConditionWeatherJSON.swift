//
//  ConditionWeatherJSON.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 30/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

class ConditionWeatherJSON {
    
    struct Condition: Decodable {
        var id: Int
    }
    
//    struct Code: Decodable {
//        var code: Int
//    }
    
    
    
    func getCondition() {
        let urlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let weather = try JSONDecoder().decode(Condition.self, from: data)
                print("==================== \(weather)")

            } catch let error { print(error) }
        }.resume()
    }
    
}
