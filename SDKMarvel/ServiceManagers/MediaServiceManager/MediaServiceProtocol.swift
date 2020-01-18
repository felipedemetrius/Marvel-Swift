//
//  MediaServiceProtocol.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

public protocol MediaServiceProtocol {

    ///Function used to get a list of media related to a character. Eg: comics, series, events, stories.
    ///
    /// - Parameters:
    ///   - completionHandler: Completion returning a Result<[Media], NetworkingError>.
    func get(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void)

    ///Function used for get next page of list of media.
    ///
    /// - Parameters:
    ///   - completionHandler: Completion returning a Result<[Media], NetworkingError>.
    mutating func getNext(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void)
}
