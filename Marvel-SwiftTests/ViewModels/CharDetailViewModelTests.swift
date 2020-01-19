//
//  CharDetailViewModel.swift
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
        let viewModel = CharDetailFakeViewModel()

        describe("Given that I opened the list of media") {
            context("When the list is loaded") {
                viewModel.setDatasource()
                
                it("Then the first title's name is") {
                    expect(viewModel.dataSource.value.first?.title).to(contain("fake"))
                }
            }
        }
        describe("Given that I opened the list of media") {
            context("When I make a pagination") {
                viewModel.nextPage()
                
                it("Then the next title's name is") {
                    expect(viewModel.dataSource.value.last?.title).to(contain("fake 2"))
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
    
    init() {
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.dataSource = Observable([])
        self.service = MediaServiceManager(url: "")
        self.image = Observable(nil)
        self.character = Character()
    }
    
    func setDatasource() {
        var media = Media()
        media.title = "fake"
        dataSource.value = [media]
    }
    
    func nextPage() {
        var media = Media()
        media.title = "fake 2"
        dataSource.value.append(media)
    }
    
    func handler(result: Result<[Media], NetworkingError>) {
        
    }
}
