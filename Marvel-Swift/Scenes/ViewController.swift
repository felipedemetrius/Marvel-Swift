//
//  ViewController.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 17/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit
import SDKMarvel

class ViewController: UIViewController {
    let service = CharacterServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.get { result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

