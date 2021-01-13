//
//  MediaServiceManagerTests.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Nimble
import Quick
import OHHTTPStubs
@testable import SDKMarvel

class MediaServiceManagerTests: QuickSpec {
    override func spec() {
        let sut: MediaServiceProtocol = MediaServiceManager(url: "http://gateway.marvel.com/v1/public/characters/1011334/comics")
        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
        describe("Given I have made a successful service request") {
            context("When I receive valid data from the server.") {
                beforeEach {
                    MediaServiceStubs.responseSuccessCode200()
                }
                it("Then decode the data into a valid data") {
                    waitUntil { done  in
                        sut.get({ result in
                            switch result {
                            case .success(let value):
                                expect(value).to(beAKindOf([Media].self))
                                expect(value.first).to(beAKindOf(Media.self))
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
        describe("Given I have made a successful service request. But the format of the server data has changed. ") {
            beforeEach {
                MediaServiceStubs.responseFailSerialization()
            }
            it("Then the decode the data fail") {
                waitUntil { done  in
                    sut.get({ result in
                        switch result {
                        case .success:
                            fail()

                        case .failure(let error):
                            expect(error).notTo(beNil())
                            expect(error.localizedDescription).to(contain("Decoding error"))

                        }
                        done()
                    })
                }
            }
        }
        describe("Given I made a service request and received status code 404 failure.") {
            beforeEach {
                MediaServiceStubs.responseFailureCode404()
            }
            it("Then I received a NetworkingError") {
                waitUntil { done  in
                    sut.get({ result in
                        switch result {
                        case .success:
                            fail()

                        case .failure(let error):
                            expect(error).notTo(beNil())
                        }
                        done()
                    })
                }
            }
        }
        describe("Given I made a service request with Invalid credentials.") {
            beforeEach {
                MediaServiceStubs.responseFailureCode401()
            }
            it("Then I received a error of server") {
                waitUntil { done  in
                    sut.get({ result in
                        switch result {
                        case .success:
                            fail()

                        case .failure(let error):
                            expect(error).notTo(beNil())
                            expect(error.localizedDescription).to(contain("InvalidCredentials"))
                        }
                        done()
                    })
                }
            }
        }
        describe("Given I made a request requesting more objects (pagination)") {
            beforeEach {
                MediaServiceStubs.responseSuccessCode200()
            }
            it("Then I received objects from server") {
                var next = MediaServiceManager(url: "http://gateway.marvel.com/v1/public/characters/1011334/comics")
                waitUntil { done  in
                    next.getNext({ result in
                        switch result {
                        case .success(let value):
                            expect(value).to(beAKindOf([Media].self))
                            expect(value.first).to(beAKindOf(Media.self))
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
}
