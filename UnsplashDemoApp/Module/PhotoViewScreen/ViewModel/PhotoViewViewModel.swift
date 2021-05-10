//
//  PhotoViewViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Foundation

protocol PhotoViewViewModelProtocol {
    var photoImage: String { get }
    var photoUser: String { get }
    var photo: TopicPhoto { get }
}

class PhotoViewViewModel: PhotoViewViewModelProtocol {
    
    private var photoData: TopicPhoto
    
    init(photoData: TopicPhoto) {
        self.photoData = photoData
    }
    
    var photoImage: String {
        photoData.urls?.small ?? ""
    }
    
    var photoUser: String {
        "\(photoData.user?.firstName ?? "") \(photoData.user?.lastName ?? "")"
    }
    
    var photo: TopicPhoto {
        photoData
    }
    
    func passUserData() -> UserDetailViewModel {
        UserDetailViewModel(userDataSource: photoData)
    }
}
