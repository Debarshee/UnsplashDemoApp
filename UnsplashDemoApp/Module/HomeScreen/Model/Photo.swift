//
//  Photo.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import Foundation

struct PhotoCollection: Decodable {
    var photos: [Photo]?
}

struct Photo: Decodable {
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
    var tags: [PhotoInfo]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, curated, featured, tags
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case totalPhotos = "total_photos"
        case isPrivate = "private"
        case shareKey = "share_key"
    }
}

struct PhotoInfo: Decodable {
    var type: String?
    var title: String?
    var source: PhotoSource?
    
    enum CodingKeys: String, CodingKey {
        case type, title, source
    }
}

struct PhotoSource: Decodable {
    var ancestry: Ancestry?
    var title: String?
    var subtitle: String?
    var description: String?
    var metaTitle: String?
    var metaDescription: String?
    var coverPhoto: CoverPhotoInfo?
    
    enum CodingKeys: String, CodingKey {
        case ancestry, title, subtitle, description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case coverPhoto = "cover_photo"
    }
}

struct Ancestry: Decodable {
    var type: AncestryType?
    var category: AncestryCategory?
    var subcategory: AncestrySubcategory?
    
    enum CodingKeys: String, CodingKey {
        case type, category, subcategory
    }
}

struct AncestryType: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct AncestryCategory: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct AncestrySubcategory: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct CoverPhotoInfo: Decodable {
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
    var urls: PhotoUrls?
    var links: PhotoLinks?
    var likes: Int?
    var likedByUser: Bool
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, color, urls, links, likes, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
    }
}

struct PhotoUrls: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}

struct PhotoLinks: Decodable {
    var photoLinksSelf: String?
    var html: String?
    var download: String?
    var downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case html, download
        case photoLinksSelf = "self"
        case downloadLocation = "download_location"
    }
}

struct User: Decodable {
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
    var links: UserLinks?
    var profileImage: UserProfileImage?
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

struct UserLinks: Decodable {
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

struct UserProfileImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}
