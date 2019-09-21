//
//  HideKeyboard.swift
//  Weather
//
//  Created by yauheni prakapenka on 05/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
