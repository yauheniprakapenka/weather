//
//  CustomTableViewCell.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 27/09/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var citySearchDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
