//
//  CollectionDisplayCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import Foundation

protocol CollectionDisplayCellViewModelProtocol {
    var photoImage: String { get }
    var photoDescription: String { get }
    var photoCollectionData: PhotoModel { get }
}

class CollectionDisplayCellViewModel: CollectionDisplayCellViewModelProtocol {
    
    private var dataSource: PhotoModel
    
    init(dataSource: PhotoModel) {
        self.dataSource = dataSource
    }
    
    var photoImage: String {
        dataSource.urls?.small ?? ""
    }
    
    var photoDescription: String {
        dataSource.description ?? dataSource.altDescription ?? ""
    }
    
    var photoCollectionData: PhotoModel {
        dataSource
    }
}
