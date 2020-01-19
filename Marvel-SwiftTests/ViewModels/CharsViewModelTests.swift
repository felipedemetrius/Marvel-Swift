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
        let viewModel = CharsFakeViewModel()

        describe("Given that I opened the list of characters") {
            context("When the list is loaded") {
                viewModel.setDatasource()
                
                it("Then the first character's name is") {
                    expect(viewModel.dataSource.value.first?.name).to(contain("fake"))
                }
            }
        }
        describe("Given that I opened the list of characters") {
            context("When I make a pagination") {
                viewModel.nextPage()
                
                it("Then the next character's name is") {
                    expect(viewModel.dataSource.value.last?.name).to(contain("fake 2"))
                }
            }
        }
        describe("Given that I opened the list of characters") {
            context("When I tap a character") {
                viewModel.didSelectRowAt(row: 0)
                
                it("Then the next character's name is") {
                    expect(viewModel.didTap).to(beTrue())
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
    
    init() {
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.dataSource = Observable([])
        self.service = CharacterServiceManager()
    }
    
    func setDatasource() {
        var char = Character()
        char.name = "fake"
        dataSource.value = [char]
    }
    
    func nextPage() {
        var char = Character()
        char.name = "fake 2"
        dataSource.value.append(char)
    }
    
    func handler(result: Result<[Character], NetworkingError>) {
        
    }
    
    func didSelectRowAt(row: Int) {
        didTap = true
    }
}
