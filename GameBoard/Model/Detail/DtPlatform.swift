//
//  DtPlatform.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtPlatform: Codable {
    
    // MARK: Properties
    public var slug: String?
    public var platform: Int?
    public var name: String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
        case platform = "platform"
        case name = "name"
    }
    
}
