//
//  DtDevelopers.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtDevelopers: Codable {
    
    // MARK: Properties
    public var name: String?
    public var id: Int?
    public var slug: String?
    public var gamesCount: Int?
    public var imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
    
}
