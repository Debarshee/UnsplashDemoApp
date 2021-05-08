//
//  HomeCollectionCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import Foundation

protocol HomeCollectionCellViewModelProtocol {
    var title: String { get }
}

class HomeCollectionCellViewModel: HomeCollectionCellViewModelProtocol {
    
    var dataSource: Topic
    
    init(dataSource: Topic) {
        self.dataSource = dataSource
    }
    
    var title: String {
        dataSource.title ?? ""
    }
}
