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
    // var current_user_contributions:[],
    // var total_current_user_submissions: null,
    // var links: Links?
    // var status: String?
    // var owners: [Owner]?
    // var cover_photo: CoverPhoto?
    // "preview_photos":[]
    
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

//    struct Links {
//        "self":"https://api.unsplash.com/topics/wallpapers",
//        "html":"https://unsplash.com/t/wallpapers",
//        "photos":"https://api.unsplash.com/topics/wallpapers/photos"
//    }
//
//    struct Owner {
//        "id":"QV5S1rtoUJ0",
//        "updated_at":"2021-05-07T10:23:24-04:00",
//        "username":"unsplash",
//        "name":"Unsplash",
//        "first_name":"Unsplash",
//        "last_name":null,
//        "twitter_username":"unsplash",
//        "portfolio_url":"https://unsplash.com",
//        "bio":"Behind the scenes of the team building the internetâ€™s open library of freely useable visuals.",
//        "location":"Montreal, Canada",
//        "links":{},
//        "profile_image":{},
//        "instagram_username":"unsplash",
//        "total_collections":5,
//        "total_likes":16350,
//        "total_photos":29,
//        "accepted_tos":true,
//        "for_hire":false
//    }
//
//    struct CoverPhoto {
//        "id":"YcfCXxo7rpc",
//        "created_at":"2013-09-17T09:57:48-04:00",
//        "updated_at":"2021-05-07T11:00:05-04:00",
//        "promoted_at":"2013-09-17T09:57:48-04:00",
//        "width":3504,
//        "height":2336,
//        "color":"#26260c",
//        "blur_hash":"LEBpFJRk5TR+5toJ^ia#0KfPIoxY",
//        "description":null,
//        "alt_description":"brown house surrounded by pine trees at hill under blow skies photo during daytime",
//        "urls":{},
//        "links":{},
//        "categories":[],
//        "likes":714,
//        "liked_by_user":false,
//        "current_user_collections":[],
//        "sponsorship":null,
//        "user":{}
//    }
