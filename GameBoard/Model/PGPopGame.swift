//
//  PGPopGame.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGPopGame: Codable {
    
    // MARK: Properties
    public var next: String?
    public var userPlatforms: Bool? = false
    public var results: [PGResults]?
    public var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
        case userPlatforms = "user_platforms"
        case results = "results"
        case count = "count"
    }
    
}
