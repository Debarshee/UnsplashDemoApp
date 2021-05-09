//
//  PhotoDetailViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Foundation

protocol PhotoDetailViewModelProtocol {
    var photoImage: String { get }
}

class PhotoDetailViewModel: PhotoDetailViewModelProtocol {
    
    private var photoData: PhotoDetailInfo
    
    init(photoData: PhotoDetailInfo) {
        self.photoData = photoData
    }
    
    var photoImage: String {
        photoData.image ?? ""
    }
}
