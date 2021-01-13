//
//  CharacterDetailViewControllerTests.swift
//  Marvel-SwiftTests
//
//  Created by Felipe Silva on 13/01/21.
//  Copyright © 2021 Felipe Silva . All rights reserved.
//

import Foundation
import SDKMarvel
@testable import Marvel_Swift

final class CharacterDetailViewControllerTests: SnapshotTestCase {
    func testCharacterDetailViewController() {
        snapshot(matching: {
            let viewModel = CharDetailFakeViewModel(service: MediaServiceMock())
            return CharacterDetailViewController(viewModel: viewModel)
        })
    }
}


final class MediaServiceMock: MediaServiceProtocol {
    func get(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {
        completionHandler(Result.success([.dummy]))
    }
    
    func getNext(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {
        completionHandler(Result.success([.dummy, .dummy]))
    }
}

extension Array where Element == Media {
    static var dummy: [Media] {
        return [.dummy]
    }
}


extension Media {
    static var dummy: Media {
        var media = Media()
        media.title = "Media Test Fake"
        return media
    }
}

