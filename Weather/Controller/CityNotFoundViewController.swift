//
//  CityNotFoundViewController.swift
//  jsonparse
//
//  Created by yauheni prakapenka on 31/08/2019.
//  Copyright © 2019 yauheni prakapenka. All rights reserved.
//

import UIKit

class CityNotFoundViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        catImageView.loadGif(name: "Cats")
    }

}
