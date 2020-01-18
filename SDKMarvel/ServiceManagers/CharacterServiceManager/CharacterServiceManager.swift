//
//  CharacterServiceManager.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

/**
 Implementation of protocol CharacterServiceProtocol.
 
 ## Functions availables:
 
 Get lists of characters:
 - get(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void)

 Get next page:
 - getNext(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void)
 
 ## Example of use:
 
 ```
 let service = CharacterServiceManager()
 
 service.get { result in
    switch result {
        case .success(let value):
            print(value)
        case .failure(let error):
            print(error.localizedDescription)
    }
 }
 ```
 */

public struct CharacterServiceManager: CharacterServiceProtocol {

    private var service = CharacterService()

    public init() { }

    public func get(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {
        service.get(completionHandler)
    }

    public mutating func getNext(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {
        service.getNext(completionHandler)
    }
}
