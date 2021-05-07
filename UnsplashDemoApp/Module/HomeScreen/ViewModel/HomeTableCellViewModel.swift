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
    
    private var dataSource: PhotoInfo
    
    init(dataSource: PhotoInfo) {
        self.dataSource = dataSource
    }
    
    var image: String {
        self.dataSource.source?.coverPhoto?.urls?.thumb ?? ""
    }
    
    var name: String {
        self.dataSource.title ?? ""
    }
}
