//
//  CharDetailsut.swift
//  Marvel-SwiftTests
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Nimble
import Quick
import SDKMarvel
@testable import Marvel_Swift

class CharDetailModelTests: QuickSpec {
    override func spec() {
        let sut = CharDetailFakeViewModel(service: MediaServiceMock())

        describe("Given that I opened the detail of character") {
            context("When the list is loaded") {

                it("Then the first character's name is") {
                    expect(sut.character.name).to(contain("Test"))
                }
            }
        }
        describe("Given that I opened the list of media") {
            context("When the list is loaded") {
                sut.setDatasource()

                it("Then the first title's name is") {
                    expect(sut.dataSource.value.first?.title).to(contain("Media Test Fake"))
                }
            }
        }
        describe("Given that I opened the list of media") {
            context("When I make a pagination") {
                sut.nextPage()

                it("Then the next title's name is") {
                    expect(sut.dataSource.value.last?.title).to(contain("Media Test Fake"))
                }
                it("Then the variable didNext change for true") {
                    expect(sut.didNext).to(beTrue())
                }
            }
        }
    }
}

final class CharDetailFakeViewModel: CharacterDetailViewProtocol {
    var service: MediaServiceProtocol
    var error: Observable<String?>
    var isLoading: Observable<Bool>
    var isLoadingNext: Observable<Bool>
    var dataSource: Observable<[Media]>
    var character: Character
    var image: Observable<UIImage?>

    var didNext = false

    init(service: MediaServiceProtocol, character: Character = .dummy) {
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.dataSource = Observable([])
        self.service = service
        self.image = Observable(UIImage(named: "placeholder"))
        self.character = character
        self.setDatasource()
    }

    func setDatasource() {
        service.get(handler)
    }

    func nextPage() {
        service.getNext(handler)
        didNext = true
    }

    func handler(result: Result<[Media], NetworkingError>) {
        switch result {
        case .success(let value):
            self.dataSource.value.append(contentsOf: value)
            self.error.value = nil

        case .failure(let error):
            self.error.value = error.localizedDescription
        }
    }
}
