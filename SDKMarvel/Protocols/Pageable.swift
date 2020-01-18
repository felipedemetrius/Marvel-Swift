//
//  Pageable.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import Alamofire

protocol Pageable: Requestable {
    var page: Int {get set}

    mutating func getNext(_ completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void)
    func getPage(page: Int, completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void)
}

extension Pageable {
    mutating public func getNext(_ completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void) {
        page += API.limit
        getPage(page: page, completionHandler: completionHandler)
    }
}
