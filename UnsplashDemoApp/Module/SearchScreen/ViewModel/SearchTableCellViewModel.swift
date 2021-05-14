//
//  SearchTableCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import Foundation

protocol SearchTableCellViewModelProtocol {
    var image: String { get }
    var title: String { get }
}

class SearchTableCellViewModel: SearchTableCellViewModelProtocol {
    
    private var dataSource: PhotoModel
    
    init(dataSource: PhotoModel) {
        self.dataSource = dataSource
    }
    
    var image: String {
        dataSource.urls?.small ?? ""
    }
    
    var title: String {
        dataSource.description ?? dataSource.altDescription ?? ""
    }
}
