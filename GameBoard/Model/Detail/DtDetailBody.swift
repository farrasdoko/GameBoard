//
//  DtDetailBody.swift
//
//  Created by Farras Doko on 23/07/20
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct DtDetailBody: Codable {
    
    // MARK: Properties
    public var suggestionsCount: Int?
    public var backgroundImageAdditional: String?
    public var updated: String?
    public var parentPlatforms: [DtParentPlatforms]?
    public var creatorsCount: Int?
    public var id: Int?
    public var youtubeCount: Int?
    public var released: String?
    public var twitchCount: Int?
    public var developers: [DtDevelopers]?
    public var screenshotsCount: Int?
    public var redditDescription: String?
    public var website: String?
    public var descriptionValue: String?
    public var parentAchievementsCount: Int?
    public var platforms: [DtPlatforms]?
    public var rating: Float?
    public var ratingTop: Int?
    public var added: Int?
    public var redditUrl: String?
    public var gameSeriesCount: Int?
    public var achievementsCount: Int?
    public var alternativeNames: [String]?
    public var dominantColor: String?
    public var reviewsCount: Int?
    public var ratingsCount: Int?
    public var tba: Bool? = false
    public var parentsCount: Int?
    public var slug: String?
    public var ratings: [DtRatings]?
    public var clip: DtClip?
    public var additionsCount: Int?
    public var saturatedColor: String?
    public var publishers: [DtPublishers]?
    public var name: String?
    public var metacriticUrl: String?
    public var playtime: Int?
    public var genres: [DtGenres]?
    public var nameOriginal: String?
    public var metacritic: Int?
    public var redditCount: Int?
    public var redditLogo: String?
    public var backgroundImage: String?
    public var redditName: String?
    public var moviesCount: Int?
    public var descriptionRaw: String?
    public var reviewsTextCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case suggestionsCount = "suggestions_count"
        case backgroundImageAdditional = "background_image_additional"
        case updated = "updated"
        case parentPlatforms = "parent_platforms"
        case creatorsCount = "creators_count"
        case id = "id"
        case youtubeCount = "youtube_count"
        case released = "released"
        case twitchCount = "twitch_count"
        case developers = "developers"
        case screenshotsCount = "screenshots_count"
        case redditDescription = "reddit_description"
        case website = "website"
        case descriptionValue = "description"
        case parentAchievementsCount = "parent_achievements_count"
        case platforms = "platforms"
        case rating = "rating"
        case ratingTop = "rating_top"
        case added = "added"
        case redditUrl = "reddit_url"
        case gameSeriesCount = "game_series_count"
        case achievementsCount = "achievements_count"
        case alternativeNames = "alternative_names"
        case dominantColor = "dominant_color"
        case reviewsCount = "reviews_count"
        case ratingsCount = "ratings_count"
        case tba = "tba"
        case parentsCount = "parents_count"
        case slug = "slug"
        case ratings = "ratings"
        case clip = "clip"
        case additionsCount = "additions_count"
        case saturatedColor = "saturated_color"
        case publishers = "publishers"
        case name = "name"
        case metacriticUrl = "metacritic_url"
        case playtime = "playtime"
        case genres = "genres"
        case nameOriginal = "name_original"
        case metacritic = "metacritic"
        case redditCount = "reddit_count"
        case redditLogo = "reddit_logo"
        case backgroundImage = "background_image"
        case redditName = "reddit_name"
        case moviesCount = "movies_count"
        case descriptionRaw = "description_raw"
        case reviewsTextCount = "reviews_text_count"
    }
}
