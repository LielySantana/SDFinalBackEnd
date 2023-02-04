//
//  hashtagModel.swift
//  Story Downloader
//
//  Created by Christina Santana on 1/11/22.
//

import Foundation

// MARK: - Model
struct HashtagModel: Codable {
    let data: DataClass
    let status, statusMessage: String
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case data, status
        case statusMessage = "status_message"
        case meta = "@meta"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let distinctHashtagsCount: Int
    let hashtags: [Hashtag]

    enum CodingKeys: String, CodingKey {
        case distinctHashtagsCount = "distinct_hashtags_count"
        case hashtags
    }
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let hashtag: String
    let relevance: Int
}

// MARK: - Meta
struct Meta: Codable {
    let apiVersion, executionTime: String
    let cacheHit: Bool

    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case executionTime = "execution_time"
        case cacheHit = "cache_hit"
    }
}
