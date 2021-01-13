//
//  CharsViewControllerTests.swift
//  Marvel-SwiftTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Nimble
import Quick
import SDKMarvel
@testable import Marvel_Swift

class CharsViewModelTests: QuickSpec {
    override func spec() {
        let sut = CharsFakeViewModel(service: CharsServiceMock())

        describe("Given that I opened the list of characters") {
            context("When the list is loaded") {
                sut.setDatasource()

                it("Then the first character's name is") {
                    expect(sut.dataSource.value.first?.name).to(contain("fake"))
                }
            }
        }
        describe("Given that I opened the list of characters") {
            context("When I make a pagination") {
                sut.nextPage()

                it("Then the next character's name is") {
                    expect(sut.dataSource.value.last?.name).to(contain("Test fake"))
                }
            }
        }
        describe("Given that I opened the list of characters") {
            context("When I tap a character") {
                sut.didSelectRowAt(row: 0)

                it("Then the next character's name is") {
                    expect(sut.didTap).to(beTrue())
                }
            }
        }
    }
}

final class CharsFakeViewModel: CharactersViewProtocol {
    var service: CharacterServiceProtocol
    var title: String = ""
    var error: Observable<String?>
    var isLoading: Observable<Bool>
    var isLoadingNext: Observable<Bool>
    var dataSource: Observable<[Character]>

    var didTap = false

    init(service: CharacterServiceProtocol) {
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.dataSource = Observable([])
        self.service = service
        self.setDatasource()
    }

    func setDatasource() {
        service.get(handler)
    }

    func nextPage() {
        service.getNext(handler)
    }

    func handler(result: Result<[Character], NetworkingError>) {
        switch result {
        case .success(let value):
            self.dataSource.value.append(contentsOf: value)
            self.error.value = nil

        case .failure(let error):
            self.error.value = error.localizedDescription
        }
    }

    func didSelectRowAt(row: Int) {
        didTap = true
    }
}
