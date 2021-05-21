//
//  Topic.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import Foundation

struct Topic: Decodable {
    var id: String?
    var slug: String?
    var title: String?
    var topicDescription: String?
    var publishedAt: String?
    var updatedAt: String?
    var startsAt: String?
    var endsAt: String?
    var featured: Bool
    var totalPhotos: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title, featured
        case topicDescription = "description"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case totalPhotos = "total_photos"
    }
}
