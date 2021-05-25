//
//  ProfileModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/22/21.
//

import Foundation

struct ProfileModel {
    var email: String?
    var uid: String?
    var photoLikedByUser: [PhotoModel]?
    var photoByUser: [PhotoModel]?
    var collectionsByUser: [PhotoModelUserCollection]?
    var dictionary: [String: Any] {
        [
            "email": email as Any,
            "uid": uid as Any,
            "photoLikedByUser": photoLikedByUser as Any,
            "photoByUser": photoByUser as Any,
            "collectionsByUser": collectionsByUser as Any
        ]
    }
}
