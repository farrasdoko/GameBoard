//
//  PGClips.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGClips: Codable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        
    }
    
    // MARK: Properties
    public var full: String?
    public var res320: String?
    public var res640: String?
    
    enum CodingKeys: String, CodingKey {
        case full = "full"
        case res320 = "320"
        case res640 = "640"
    }
    
}
