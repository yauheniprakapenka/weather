//
//  Date.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import Foundation

class CurrentDate {
    
    func getCurrentDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm:ss yyyy-MM-dd"
        let formattedDate = format.string(from: date)

        return formattedDate
    }
    
}
