//
//  ImageServiceManager.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit

public struct ImageServiceManager: ImageServiceProtocol {
    private var service = ImageDownloaderService()

    public init() { }

    public func downloadImage(url: String, _ completionHandler: @escaping (Result<UIImage, NetworkingError>) -> Void) {
        service.downloadImage(url: url, completionHandler: completionHandler)
    }
}
