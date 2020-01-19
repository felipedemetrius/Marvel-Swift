//
//  ImageTests.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Nimble
import Quick
import OHHTTPStubs
@testable import SDKMarvel

class ImageTests: QuickSpec {
    override func spec() {
        let service: ImageServiceProtocol = ImageServiceManager()
        let url = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"

        let urlInvalid = ""

        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
        describe("Given I made a successful service request to download an image.") {
            context("When I receive valid data from the server.") {
                beforeEach {
                    ImageDownloaderStubs.responseSuccessCode200()
                }
                it("Then the data decoding to UIImage is successful.") {
                    waitUntil(timeout: 20) { done in
                        service.downloadImage(url: url, { result in
                            switch result {
                            case .success(let value):
                                expect(value).to(beAKindOf(UIImage.self))
                                expect(value).notTo(beNil())

                            case .failure:
                                fail()
                            }
                            done()
                        })
                    }
                }
            }
        }
        describe("Given I made a fail service request to download an image") {
            context("When I do not receive any data from the server because I passed an invalid url.") {
                beforeEach {
                    ImageDownloaderStubs.responseFailureCode404()
                }
                it("Then the decoding the data fail.") {
                    waitUntil(timeout: 20) { done in
                        service.downloadImage(url: urlInvalid, { result in
                            switch result {
                            case .success:
                                fail()

                            case .failure(let error):
                                expect(error).notTo(beNil())
                                expect(error.localizedDescription).to(contain("Invalid URL"))
                            }
                            done()
                        })
                    }
                }
            }
        }
    }
}
