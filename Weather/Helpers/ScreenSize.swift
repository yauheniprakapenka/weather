//
//  ScreenSize.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 08/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class ScreenSize {
    private let screenSize: CGRect = UIScreen.main.bounds
    private var newScreenWidth = 0.0
    private var newScreenHeight = 0.0
    
    func fetchWidth() -> Double {
        let screenWidth = screenSize.width
        newScreenWidth = Double((28 * screenWidth) / 100)
        
        return newScreenWidth
    }
    
    func fetchHeight() -> Double {
        let screenHeight = screenSize.height
        newScreenHeight = Double((28 * screenHeight) / 100)
        
        return newScreenHeight
    }
    
}
