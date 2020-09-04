//
//  PGClip.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGClip: Codable {
    
    // MARK: Properties
    public var clips: PGClips?
    public var video: String?
    public var preview: String?
    public var clip: String?
    
    enum CodingKeys: String, CodingKey {
        case clips = "clips"
        case video = "video"
        case preview = "preview"
        case clip = "clip"
    }
    
}
