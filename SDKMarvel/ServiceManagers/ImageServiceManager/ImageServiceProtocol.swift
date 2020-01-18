//
//  ImageServiceProtocol.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import UIKit

public protocol ImageServiceProtocol {

    ///Function used for download a image from url.
    ///
    /// - Parameters:
    ///   - url: url String of image.
    ///   - completionHandler: Completion returning a Result<UIImage, NetworkingError>.
    func downloadImage(url: String, _ completionHandler: @escaping (Result<UIImage, NetworkingError>) -> Void)
}
