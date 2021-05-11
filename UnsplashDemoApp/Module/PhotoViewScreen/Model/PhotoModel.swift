//
//  PhotoModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import Foundation

struct PhotoModel: Decodable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var blurHash: String?
    var description: String?
    var altDescription: String?
    var urls: PhotoModelUrls?
    var links: PhotoModelLinks
    // "categories":[],
    var likes: Int?
    var likedByUser: Bool
    var currentUserCollections: [PhotoModelUserCollection]?
    // "sponsorship":null,
    var user: PhotoModelUser?
    var exif: PhotoModelExtraInfo?
    var location: PhotoModelLocation?
    var meta: PhotoModelMeta?
    var tags: [PhotoModelTags]?
    var relatedCollections: PhotoModelRelatedCollections?
    var views: Int?
    var downloads: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, color, description, urls, links, likes, user, exif, location, meta, tags, views, downloads
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case relatedCollections = "related_collections"
    }
}

struct PhotoModelUrls: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}

struct PhotoModelLinks: Decodable {
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

struct PhotoModelUserCollection: Decodable {
    var id: Int?
    var title: String?
    var publishedAt: String?
    var lastCollectedAt: String?
    var updatedAt: String?
    // var cover_photo: null,
    // "user": null
    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
    }
}

struct PhotoModelUser: Decodable {
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
    var links: PhotoModelUserLinks?
    var profileImage: PhotoModelUserProfileImage?
    var instagramUsername: String?
    var totalCollections: String?
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

struct PhotoModelUserLinks: Decodable {
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

struct PhotoModelUserProfileImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}

struct PhotoModelExtraInfo: Decodable {
    var make: String?
    var model: String?
    var exposureTime: String?
    var aperture: String?
    var focalLength: String?
    var iso: Int?
    
    enum CodingKeys: String, CodingKey {
        case make, model, aperture, iso
        case exposureTime = "exposure_time"
        case focalLength = "focal_length"
    }
}

struct PhotoModelLocation: Decodable {
    var city: String?
    var country: String?
    var position: PhotoModelLocationPosition?
    
    enum CodingKeys: String, CodingKey {
        case city, country, position
    }
}

struct PhotoModelLocationPosition: Decodable {
    var latitude: Double?
    var longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
}

struct PhotoModelMeta: Decodable {
    var index: Bool
    
    enum CodingKeys: String, CodingKey {
        case index
    }
}

struct PhotoModelTags: Decodable {
    var type: String?
    var title: String?
    var source: PhotoModelSource?
    
    enum CodingKeys: String, CodingKey {
        case type, title, source
    }
}

struct PhotoModelSource: Decodable {
    var ancestry: PhotoModelAncestry?
    var title: String?
    var subtitle: String?
    var description: String?
    var metaTitle: String?
    var metaDescription: String?
    var coverPhoto: PhotoModelCoverPhoto?
    
    enum CodingKeys: String, CodingKey {
        case ancestry, title, subtitle, description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case coverPhoto = "cover_photo"
    }
}

struct PhotoModelAncestry: Decodable {
    var type: PhotoModelAncestryType?
    var category: PhotoModelAncestryCategory?
    var subcategory: PhotoModelAncestrySubcategory?
    
    enum CodingKeys: String, CodingKey {
        case type, category, subcategory
    }
}

struct PhotoModelAncestryType: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct PhotoModelAncestryCategory: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct PhotoModelAncestrySubcategory: Decodable {
    var slug: String?
    var prettySlug: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case prettySlug = "pretty_slug"
    }
}

struct PhotoModelCoverPhoto: Decodable {
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
    var urls: PhotoModelCoverPhotoUrls?
    var links: PhotoModelCoverPhotoLinks?
    var likes: Int?
    var likedByUser: Bool
    var user: PhotoModelCoverPhotoUser?
    
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

struct PhotoModelCoverPhotoUrls: Decodable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}

struct PhotoModelCoverPhotoLinks: Decodable {
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

struct PhotoModelCoverPhotoUser: Decodable {
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
    var links: PhotoModelCoverPhotoUserLinks?
    var profileImage: PhotoModelCoverPhotoUserProfileImage?
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

struct PhotoModelCoverPhotoUserLinks: Decodable {
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

struct PhotoModelCoverPhotoUserProfileImage: Decodable {
    var small: String?
    var medium: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, medium, large
    }
}

struct PhotoModelRelatedCollections: Decodable {
    var total: Int?
    var type: String?
    // var results: [PhotoModelRelatedCollectionResults]?
    
    enum CodingKeys: String, CodingKey {
        case total, type
    }
}

// struct PhotoModelRelatedCollectionResults {
//
// }
