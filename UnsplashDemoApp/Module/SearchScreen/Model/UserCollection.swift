//
//  UserCollection.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import Foundation

struct UserCollection: Decodable {
    var total: Int?
    var totalPages: Int?
    var results: [UnsplashUser]?
    
    enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}

struct UnsplashUser: Decodable {
    var id: String?
    var updatedAt: String?
    var username: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var twitterUsername: String?
    var portfolioUrl: String?
    var bio: String?
    var location: String?
    var links: UnsplashUserLinks?
    var profileImage: UnsplashUserProfileImage?
    var instagramUsername: String?
    var totalCollections: Int?
    var totalLikes: Int?
    var totalPhotos: Int?
    var acceptedTos: Bool
    var forHire: Bool
    var photos: [UnsplashUserPhotos]?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, bio, links, photos
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
    }
}

struct UnsplashUserLinks: Decodable {
    var userLinks: String?
    var html: String?
    var photos: String?
    var likes: String?
    var portfolio: String?
    var following: String?
    var followers: String?
    
    enum CodingKeys: String, CodingKey {
        case html, photos, likes, portfolio, following, followers
        case userLinks = "self"
    }
}

struct UnsplashUserProfileImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}

struct UnsplashUserPhotos: Decodable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var blurHash: String?
    var urls: UnsplashUserPhotosUrls?
    
    enum CodingKeys: String, CodingKey {
        case id, urls
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
    }
}

struct UnsplashUserPhotosUrls: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}
