//
//  CharacterServiceProtocol.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

public protocol CharacterServiceProtocol {

    ///Function used for get lists of characters.
    ///
    /// - Parameters:
    ///   - completionHandler: Completion returning a Result<[CharacterModel], NetworkingError>.
    func get(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void)

    ///Function used for get next page of list of characters.
    ///
    /// - Parameters:
    ///   - completionHandler: Completion returning a Result<[CharacterModel], NetworkingError>.
    mutating func getNext(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void)
}
