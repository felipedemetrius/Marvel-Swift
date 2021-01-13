//
//  CharactersViewControllerTests.swift
//  Marvel-SwiftTests
//
//  Created by Felipe Silva on 13/01/21.
//  Copyright © 2021 Felipe Silva . All rights reserved.
//

import Foundation
import SDKMarvel
@testable import Marvel_Swift

final class CharactersViewControllerTests: SnapshotTestCase {
    func testCharactersViewController() {
        snapshot(matching: {
            let viewModel = CharsFakeViewModel(service: CharsServiceMock())
            return CharactersViewController(viewModel: viewModel)
        })
    }
}

final class CharsServiceMock: CharacterServiceProtocol {
    func get(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {
        completionHandler(Result.success([.dummy]))
    }
    
    func getNext(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {
        completionHandler(Result.success([.dummy, .dummy]))
    }
}

extension Array where Element == Character {
    static var dummy: [Character] {
        return [.dummy]
    }
}


extension Character {
    static var dummy: Character {
        var char = Character()
        char.name = "Test fake"
        char.characterDescription = "Description Fake"
        return char
    }
}
