//
//  API.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

struct API {
    static let limit = 20
    static let host = "https://gateway.marvel.com"

    enum Path: String {
        case characters = "/v1/public/characters"
    }
    struct Endpoints {
        public static func makeUrl(path: Path) -> String {
            return host + path.rawValue
        }
    }
}
