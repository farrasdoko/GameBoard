//
//  PGRatings.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGRatings: Codable {
    
    // MARK: Properties
    public var title: String?
    public var percent: Float?
    public var id: Int?
    public var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case percent = "percent"
        case id = "id"
        case count = "count"
    }
    
}
