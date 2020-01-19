//
//  CharCellViewModel.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit
import SDKMarvel

protocol ObjectCellProtocol {
    var title: String? { get }
    var urlImage: String { get }
    var isLoading: Observable<Bool> { get }
    var image: Observable<UIImage?> { get }
}

struct ObjectCellViewModel: ObjectCellProtocol {
    var title: String?
    var urlImage: String
    var image: Observable<UIImage?>
    var isLoading: Observable<Bool>
    private var service = ImageServiceManager()

    init(title: String,
         urlImage: String? = nil) {

        self.title = title
        self.image = Observable(nil)
        self.isLoading = Observable(false)
        self.image = Observable(UIImage(named: "placeholder"))
        self.urlImage = urlImage ?? ""

        setImage()
    }

    private func setImage() {
        isLoading.value = true
        service.downloadImage(url: urlImage, handler)
    }

    private func handler(result: Result<UIImage, NetworkingError>) {
        self.isLoading.value = false
        switch result {
        case .success(let value):
            self.image.value = value

        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
