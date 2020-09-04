//
//  PGPlatform.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGPlatform: Codable {
    
    // MARK: Properties
    public var id: Int?
    public var name: String?
    public var slug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug = "slug"
    }
    
}
