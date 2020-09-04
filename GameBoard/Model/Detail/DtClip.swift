//
//  DtClip.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtClip: Codable {
    
    // MARK: Properties
    public var video: String?
    public var preview: String?
    public var clip: String?
    
    enum CodingKeys: String, CodingKey {
        case video = "video"
        case preview = "preview"
        case clip = "clip"
    }
}
