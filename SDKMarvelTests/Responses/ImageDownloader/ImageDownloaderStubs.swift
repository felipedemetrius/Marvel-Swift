//
//  ImageDownloaderStubs.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import OHHTTPStubs

final public class ImageDownloaderStubs {
    static let endpoint = "/u/prod/marvel/i/mg/c/e0/535fecbbb9784"

    static public func responseSuccessCode200() {
        guard let path = OHPathForFile("char.jpg", ImageDownloaderStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "text/plain"]
            )
        }
    }
    static public func responseFailureCode404() {
        guard let path = OHPathForFile("ImageNull.json", ImageDownloaderStubs.self) else { return }
        stub(condition: isPath(endpoint)) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: path,
                statusCode: 404,
                headers: ["Content-Type": "text/plain"]
            )
        }
    }
}
