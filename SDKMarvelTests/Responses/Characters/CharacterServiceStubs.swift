//
//  CharacterServiceStubs.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import OHHTTPStubs

final class CharacterServiceStubs {
    static func responseSuccessCode200() {
        let endpoint = "/v1/public/characters"
        guard let path = OHPathForFile("Characters.json", CharacterServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseNoObjectSuccessCode200() {
        let endpoint = "/v1/public/characters"
        guard let path = OHPathForFile("CharsNull.json", CharacterServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailSerialization() {
        let endpoint = "/v1/public/characters"
        guard let path = OHPathForFile("CharFailSerialization.json", CharacterServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailureCode404() {
        let endpoint = "/v1/public/characters"
        guard let path = OHPathForFile("CharsNull.json", CharacterServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 404,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailureCode401() {
        let endpoint = "/v1/public/characters"
        guard let path = OHPathForFile("Error401.json", CharacterServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 401,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
}
