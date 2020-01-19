//
//  CharacterDetailViewModel.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 19/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import SDKMarvel
import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    var service: MediaServiceProtocol { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    var isLoadingNext: Observable<Bool> { get }
    var dataSource: Observable<[Media]> { get }
    var character: Character { get }
    var image: Observable<UIImage?> { get }

    func setDatasource()
    func nextPage()
    func handler(result: Result<[Media], NetworkingError>)
}

final class CharacterDetailViewModel: CharacterDetailViewProtocol {
    var dataSource: Observable<[Media]>
    var isLoading: Observable<Bool>
    var isLoadingNext: Observable<Bool>
    var error: Observable<String?>
    var character: Character
    var image: Observable<UIImage?>
    var service: MediaServiceProtocol
    private var serviceImage = ImageServiceManager()

    init(character: Character) {
        self.character = character
        self.dataSource = Observable([])
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.error = Observable(nil)
        self.service = MediaServiceManager(url: character.comics?.collectionURI ?? "")
        self.image = Observable(UIImage(named: "placeholder"))

        self.setImage(url: character.urlImage ?? "")
        self.setDatasource()
    }

    private func setImage(url: String) {
        serviceImage.downloadImage(url: url, handlerImage)
    }

    private func handlerImage(result: Result<UIImage, NetworkingError>) {
        switch result {
        case .success(let value):
            self.image.value = value

        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func setDatasource() {
        isLoading.value = true
        service.get(handler)
    }

    func nextPage() {
        isLoadingNext.value = true
        service.getNext(handler)
    }

    func handler(result: Result<[Media], NetworkingError>) {
        switch result {
        case .success(let value):
            self.dataSource.value.append(contentsOf: value)
            self.error.value = nil

        case .failure(let error):
            self.error.value = error.localizedDescription
        }
        self.isLoadingNext.value = false
        self.isLoading.value = false
    }
}
