//
//  ProfileData.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/24/21.
//

import Firebase
import FirebaseDatabase
import Foundation

struct ProfileData {
    let ref: DatabaseReference?
    let key: String
    let photoIds: [String]
    let likedPhotos: [String]
    let addedByUser: String
    var completed: Bool
  
    init(photoIds: [String], likedPhotos: [String], addedByUser: String, completed: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.photoIds = photoIds
        self.likedPhotos = likedPhotos
        self.addedByUser = addedByUser
        self.completed = completed
  }
  
  init?(snapshot: DataSnapshot) {
    guard let value = snapshot.value as? [String: AnyObject],
          let photoIds = value["photoIds"] as? [String],
          let likedPhotos = value["likedPhotoIds"] as? [String],
          let addedByUser = value["addedByUser"] as? String,
          let completed = value["completed"] as? Bool else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.key = snapshot.key
    self.photoIds = photoIds
    self.likedPhotos = likedPhotos
    self.addedByUser = addedByUser
    self.completed = completed
  }
  
  func toAnyObject() -> Any {
    [
        "photoIds": photoIds,
        "likedPhotoIds": likedPhotos,
        "addedByUser": addedByUser,
        "completed": completed
    ]
  }
}
