//
//  ImageDownloaderService.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit

struct ImageDownloaderService: Requestable {
    typealias Data = UIImage

    init() { }

    func downloadImage(url: String, _ completionHandler: @escaping (Result<UIImage, NetworkingError>) -> Void) {
        downloadImage(url: url, completionHandler: completionHandler)
    }
}
