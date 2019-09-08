//
//  Weather.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 02/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

struct SearchApixuResults: Decodable {
    var location: Location?
    var current: Current?
    
    struct Location: Decodable {
        var name: String
    }
    
    struct Current: Decodable {
        var temp_c: Int
        var condition: Condition?
        
        struct Condition: Decodable {
            var text: String
            var icon: String
            var code: Int
        }
    }
    
}
