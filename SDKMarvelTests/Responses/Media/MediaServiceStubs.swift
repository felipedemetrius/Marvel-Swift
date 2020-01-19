//
//  MediaServiceStubs.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation
import OHHTTPStubs

final class MediaServiceStubs {
    static func responseSuccessCode200() {
        let endpoint = "/v1/public/characters/1011334/comics"
        guard let path = OHPathForFile("Media.json", MediaServiceStubs.self) else { return }

        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseNoObjectSuccessCode200() {
        let endpoint = "/v1/public/characters/1011334/comics"
        guard let path = OHPathForFile("CharsNull.json", MediaServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailSerialization() {
        let endpoint = "/v1/public/characters/1011334/comics"
        guard let path = OHPathForFile("MediaFailSerialization.json", MediaServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailureCode404() {
        let endpoint = "/v1/public/characters/1011334/comics"
        guard let path = OHPathForFile("CharsNull.json", MediaServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 404,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
    static func responseFailureCode401() {
        let endpoint = "/v1/public/characters/1011334/comics"
        guard let path = OHPathForFile("Error401.json", MediaServiceStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 401,
                headers: ["Content-Type": "application/json"]
            )
        }
    }
}
