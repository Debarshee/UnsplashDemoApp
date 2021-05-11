//
//  TopicPhoto.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/8/21.
//

import Foundation

struct TopicPhoto: Decodable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var promotedAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var blurHash: String?
    var description: String?
    var altDescription: String?
    var urls: TopicPhotoUrl?
    var links: TopicPhotoLinks?
    var likes: Int?
    var likedByUser: Bool
    var user: TopicPhotoUserInfo?
    var tags: [PhotoInfo]?
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, color, description, urls, links, likes, user, tags
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
    }
}

struct TopicPhotoUrl: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}

struct TopicPhotoLinks: Decodable {
    var photoLink: String?
    var html: String?
    var download: String?
    var downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case html, download
        case photoLink = "self"
        case downloadLocation = "download_location"
    }
}

struct TopicPhotoUserInfo: Decodable {
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
    var links: TopicPhotoUserLinks?
    var profileImage: TopicPhotoUserImage?
    var instagramUsername: String?
    var totalCollections: Int?
    var totalLikes: Int?
    var totalPhotos: Int?
    var acceptedTos: Bool
    var forHire: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, bio, location, links
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

struct TopicPhotoUserLinks: Decodable {
        var userLink: String?
        var html: String?
        var photos: String?
        var likes: String?
        var portfolio: String?
        var following: String?
        var followers: String?
    
    enum CodingKeys: String, CodingKey {
        case html, photos, likes, portfolio, following, followers
        case userLink = "self"
    }
}

struct TopicPhotoUserImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}
