//
//  BlogCollectionCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import Foundation

protocol BlogCollectionCellViewModelProtocol {
    
    var image: String { get }
    var title: String { get }
    var name: String { get }
    var html: String { get }
    var photo: BlogPhotos { get }
}

class BlogCollectionCellViewModel: BlogCollectionCellViewModelProtocol {

    private var dataSource: BlogPhotos
    
    init(dataSource: BlogPhotos) {
        self.dataSource = dataSource
    }
    
    var image: String {
        dataSource.coverPhoto?.urls?.small ?? ""
    }
    
    var title: String {
        dataSource.coverPhoto?.altDescription ?? dataSource.coverPhoto?.description ?? ""
    }
    
    var name: String {
        dataSource.coverPhoto?.user?.name ?? ""
    }
    
    var html: String {
        dataSource.links?.html ?? ""
    }
    
    var photo: BlogPhotos {
        dataSource
    }
}
