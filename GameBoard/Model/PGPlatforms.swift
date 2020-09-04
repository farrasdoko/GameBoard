//
//  PGPlatforms.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct PGPlatforms: Codable {

  // MARK: Properties
  public var platform: PGPlatform?

  enum CodingKeys: String, CodingKey {
      case platform = "platform"
  }

}
