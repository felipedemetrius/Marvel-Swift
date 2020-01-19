//
//  Media.swift
//  SDKMarvel
//
//  Created by Felipe Silva  on 18/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import Foundation

// MARK: - Media
public struct Media: Codable {
    public var id: Int?
    public var title: String?
    public var description: String?
    public var resourceURI: String?
    public var thumbnail: Thumbnail?
    public var creators: MediaShort?
    public var characters: MediaShort?
    public var urls: [URLElement] = []

    public var urlImage: String? {
        guard let thumb = thumbnail?.path else {return nil}
        guard let extensionPath = thumbnail?.thumbnailExtension else {return nil}
        return thumb + "." + extensionPath
    }
    
    public init() {
        
    }
}
