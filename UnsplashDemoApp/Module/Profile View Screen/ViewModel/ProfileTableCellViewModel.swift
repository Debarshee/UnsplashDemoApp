//
//  ProfileTableCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/22/21.
//

import Foundation

protocol ProfileTableCellViewModelProtocol {
    var photoImage: String { get }
    var photoImageText: String { get }
}

class ProfileTableCellViewModel: ProfileTableCellViewModelProtocol {
    
    private var dataSource: PhotoModel
    
    init(dataSource: PhotoModel) {
        self.dataSource = dataSource
    }
    
    var photoImage: String {
        dataSource.urls?.small ?? ""
    }
    
    var photoImageText: String {
        dataSource.description ?? dataSource.altDescription ?? ""
    }
}
