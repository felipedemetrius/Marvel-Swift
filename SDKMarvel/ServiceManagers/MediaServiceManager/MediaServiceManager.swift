//
//  MediaServiceManager.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

/**
 Implementation of protocol MediaServiceProtocol.
 
 ## Functions availables:
 
 Get a list of media related to a character:
 - get(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void)
 
 Get next page:
 - getNext(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void)

 ## Example of use:

 ```
 let service = MediaServiceManager(url: character.comics.collectionURI)
 
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

public struct MediaServiceManager: MediaServiceProtocol {

    private var service: MediaService

    ///To instantiate this service, pass the media collectionURI.
    public init(url: String) {
        service = MediaService(url: url)
    }

    public func get(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {
        service.get(completionHandler)
    }

    public mutating func getNext(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {
        service.getNext(completionHandler)
    }
}
