//
//  BlogPhotos.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import Foundation

struct BlogPhotos: Decodable {
    var id: String?
    var title: String?
    var description: String?
    var publishedAt: String?
    var lastCollectedAt: String?
    var updatedAt: String?
    var curated: Bool
    var featured: Bool
    var totalPhotos: Int?
    var isPrivate: Bool
    var shareKey: String?
    var tags: [BlogPhotoTags]?
    var links: BlogPhotoLinks?
    var user: TopicPhotoUserInfo?
    var coverPhoto: TopicPhoto?
    // var preview_photos:[]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, curated, featured, tags
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case totalPhotos = "total_photos"
        case isPrivate = "private"
        case shareKey = "share_key"
        case coverPhoto = "cover_photo"
    }
}

struct BlogPhotoLinks: Decodable {
    var photoLink: String?
    var html: String?
    var photos: String?
    var related: String?
    
    enum CodingKeys: String, CodingKey {
        case html, photos
        case photoLink = "self"
    }
}

struct BlogPhotoTags: Decodable {
    var type: String?
    var title: String?
    var source: PhotoSource?
    
    enum CodingKeys: String, CodingKey {
        case type, title, source
    }
}
