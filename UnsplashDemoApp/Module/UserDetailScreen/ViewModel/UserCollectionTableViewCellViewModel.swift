//
//  UserCollectionTableViewCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import Foundation

protocol UserCollectionTableViewCellViewModelProtocol {
    var mainImage: String { get }
    var firstSubImage: String { get }
    var secondSubImage: String { get }
    var userCollectionTitle: String { get }
    var userCollectionUsername: String { get }
    var userCollectionPhotoNumber: String { get }
    var userCollectionTag1: String { get }
    var userCollectionTag2: String { get }
    var userCollectionTag3: String { get }
}

class UserCollectionTableViewCellViewModel {
    
    private var dataSource: PhotoModelUserCollection
    
    init(dataSource: PhotoModelUserCollection) {
        self.dataSource = dataSource
    }
    
    var mainImage: String {
        self.dataSource.coverPhoto?.urls?.small ?? ""
    }
    
    var firstSubImage: String {
        var image = ""
        if (self.dataSource.previewPhotos?.count ?? 0) > 1 {
            image = self.dataSource.previewPhotos?[1].urls?.small ?? ""
        } else {
            image = self.dataSource.coverPhoto?.urls?.small ?? ""
        }
        return image
    }
    
    var secondSubImage: String {
        var image = ""
        if (self.dataSource.previewPhotos?.count ?? 0) > 2 {
            image = self.dataSource.previewPhotos?[2].urls?.small ?? ""
        } else {
            image = self.dataSource.coverPhoto?.urls?.small ?? ""
        }
        return image
    }
    
    var userCollectionTitle: String {
        self.dataSource.title ?? ""
    }
    
    var userCollectionPhotoNumber: String {
        "\(self.dataSource.totalPhotos ?? 0) Photos - Curated by \(self.dataSource.user?.name ?? "")"
    }
    
    var userCollectionTag1: String {
        let count = self.dataSource.tags?.count ?? 0
        var tag1 = ""
        if count > 1 {
            tag1 = self.dataSource.tags?[0].title ?? ""
        }
        return tag1
    }
    
    var userCollectionTag2: String {
        let count = self.dataSource.tags?.count ?? 0
        var tag1 = ""
        if count > 1 {
            tag1 = self.dataSource.tags?[1].title ?? ""
        }
        return tag1
    }
    
    var userCollectionTag3: String {
        let count = self.dataSource.tags?.count ?? 0
        var tag1 = ""
        if count > 2 {
            tag1 = self.dataSource.tags?[2].title ?? ""
        }
        return tag1
    }
    
    var userCollectionUsername: String {
        self.dataSource.user?.username ?? ""
    }
}
