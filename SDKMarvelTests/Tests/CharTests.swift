//
//  CharTests.swift
//  SDKMarvelTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Nimble
import Quick
import OHHTTPStubs
@testable import SDKMarvel

class CharTests: QuickSpec {
    override func spec() {
        let service = CharacterServiceManager()
        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
        describe("Given I have made a successful service request") {
            context("When I receive valid data from the server.") {
                beforeEach {
                    CharacterServiceStubs.responseSuccessCode200()
                }
                it("Then decode the data into a valid data") {
                    waitUntil { done  in
                        service.get({ result in
                            switch result {
                            case .success(let value):
                                expect(value).to(beAKindOf([Character].self))
                                expect(value.first).to(beAKindOf(Character.self))
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
        describe("Given I have made a successful service request.") {
            context("When I didn't receive any data from the server.") {
                beforeEach {
                    CharacterServiceStubs.responseNoObjectSuccessCode200()
                }
                it("Then decode the data into a valid data") {
                    waitUntil { done  in
                        service.get({ result in
                            switch result {
                            case .success(let value):
                                expect(value).to(beAKindOf([Character].self))
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
                CharacterServiceStubs.responseFailSerialization()
            }
            it("Then the decode the data fail") {
                waitUntil { done  in
                    service.get({ result in
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
                CharacterServiceStubs.responseFailureCode404()
            }
            it("Then I received a NetworkingError") {
                waitUntil { done  in
                    service.get({ result in
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
                CharacterServiceStubs.responseFailureCode401()
            }
            it("Then I received a error of server") {
                waitUntil { done  in
                    service.get({ result in
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
                CharacterServiceStubs.responseSuccessCode200()
            }
            it("Then I received objects from server") {
                var next = CharacterServiceManager()
                waitUntil { done  in
                    next.getNext({ result in
                        switch result {
                        case .success(let value):
                            expect(value).to(beAKindOf([Character].self))
                            expect(value.first).to(beAKindOf(Character.self))
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
