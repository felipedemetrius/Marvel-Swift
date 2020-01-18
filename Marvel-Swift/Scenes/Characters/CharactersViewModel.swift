//
//  CharactersViewModel.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import SDKMarvel

protocol CharactersNavigationProtocol: AnyObject {
    func goToCharacterDetail(character: Character)
}

protocol CharactersViewProtocol {
    var service: CharacterServiceProtocol { get }
    var title: String { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    var isLoadingNext: Observable<Bool> { get }
    var dataSource: Observable<[Character]> { get }

    func setDatasource()
    func nextPage()
    func handler(result: Result<[Character], NetworkingError>)
    func didSelectRowAt(row: Int)
}

final class CharactersViewModel: CharactersViewProtocol {
    var title = "Characters Marvel"
    var dataSource: Observable<[Character]>
    var isLoading: Observable<Bool>
    var isLoadingNext: Observable<Bool>
    var error: Observable<String?>
    var service: CharacterServiceProtocol = CharacterServiceManager()
    private weak var navigationDelegate: CharactersNavigationProtocol?

    init(navigationDelegate: CharactersNavigationProtocol? = nil) {
        self.navigationDelegate = navigationDelegate
        self.dataSource = Observable([])
        self.isLoading = Observable(false)
        self.isLoadingNext = Observable(false)
        self.error = Observable(nil)
        self.setDatasource()
    }

    func setDatasource() {
        isLoading.value = true
        service.get(handler)
    }

    @objc func pullRefresh() {
        dataSource.value = []
        setDatasource()
    }

    func nextPage() {
        isLoadingNext.value = true
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
        self.isLoadingNext.value = false
        self.isLoading.value = false
    }

    func didSelectRowAt(row: Int) {
        guard dataSource.value.indices.contains(row) else { return }
        let char = dataSource.value[row]
        navigationDelegate?.goToCharacterDetail(character: char)
    }
}
