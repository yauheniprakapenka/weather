//
//  CityTtextField.swift
//  Weather
//
//  Created by yauheni prakapenka on 07/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class CityTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.backgroundColor = #colorLiteral(red: 0.9489471316, green: 0.9490606189, blue: 0.9489082694, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.alpha = 0.5
        self.layer.cornerRadius = 10
        self.attributedPlaceholder = NSAttributedString(string: "Какой город ищем?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }

}
