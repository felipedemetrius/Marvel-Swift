//
//  Character.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

// MARK: - Character
public struct Character: Decodable {
    public var id: Int?
    public var name, characterDescription, modified: String?
    public var resourceURI: String?
    public var urls: [URLElement]?
    public var thumbnail: Thumbnail?
    public var events, series, comics, stories: MediaShort?

    public var urlImage: String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.thumbnailExtension else {return nil}
        return thumb + "." + extensionPath
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case characterDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }

    public init() {  }
}

// MARK: - MediaShort
public struct MediaShort: Decodable {
    public var available, returned: Int?
    public var collectionURI: String?
    public var items: [MediaItem]?
}

// MARK: - MediaItem
public struct MediaItem: Decodable {
    public var resourceURI, name: String?, type: String?
}

// MARK: - Thumbnail
public struct Thumbnail: Decodable {
    public var path, thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public struct URLElement: Decodable {
    public var type, url: String?
}
