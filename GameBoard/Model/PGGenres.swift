//
//  PGGenres.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGGenres: Codable {
    
    // MARK: Properties
    public var id: Int?
    public var name: String?
    public var slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
    }
    
}
