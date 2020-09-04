//
//  DtPlatforms.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtPlatforms: Codable {
    
    // MARK: Properties
    public var platform: DtPlatform?
    public var releasedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case releasedAt = "released_at"
    }
    
}
