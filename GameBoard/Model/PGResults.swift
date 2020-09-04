//
//  PGResults.swift
//
//  Created by Farras Doko on 20/07/20
//  Copyright (c) . All rights reserved.
//

import UIKit

public struct PGResults: Codable {
    
    // MARK: Properties
    public var reviewsCount: Int?
    public var ratingsCount: Int?
    public var suggestionsCount: Int?
    public var tba: Bool? = false
    public var parentPlatforms: [PGParentPlatforms]?
    public var slug: String?
    public var ratings: [PGRatings]?
    public var id: Int?
    public var clip: PGClip?
    public var released: String?
    public var saturatedColor: String?
    public var name: String?
    public var genres: [PGGenres]?
    public var playtime: Int?
    public var platforms: [PGPlatforms]?
    public var metacritic: Int?
    public var rating: Float?
    public var ratingTop: Int?
    public var added: Int?
    public var backgroundImage: String?
    public var dominantColor: String?
    public var reviewsTextCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case reviewsCount = "reviews_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case tba = "tba"
        case parentPlatforms = "parent_platforms"
        case slug = "slug"
        case ratings = "ratings"
        case id = "id"
        case clip = "clip"
        case released = "released"
        case saturatedColor = "saturated_color"
        case name = "name"
        case genres = "genres"
        case playtime = "playtime"
        case platforms = "platforms"
        case metacritic = "metacritic"
        case rating = "rating"
        case ratingTop = "rating_top"
        case added = "added"
        case backgroundImage = "background_image"
        case dominantColor = "dominant_color"
        case reviewsTextCount = "reviews_text_count"
    }
}
