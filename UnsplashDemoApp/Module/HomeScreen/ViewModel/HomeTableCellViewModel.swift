//
//  HomeTableCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import Foundation

protocol HomeTableCellViewModelProtocol {
    var image: String { get }
    var name: String { get }
}

class HomeTableCellViewModel: HomeTableCellViewModelProtocol {
    
    private var dataSource: PhotoModel
    
    init(dataSource: PhotoModel) {
        self.dataSource = dataSource
    }
    
    var image: String {
        self.dataSource.urls?.small ?? ""
    }
    
    var name: String {
        self.dataSource.user?.name ?? ""
    }
}
