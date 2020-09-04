//
//  DtParentPlatforms.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtParentPlatforms: Codable {

  // MARK: Properties
  public var platform: DtPlatform?
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }

}
