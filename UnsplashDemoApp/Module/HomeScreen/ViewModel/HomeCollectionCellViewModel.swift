//
//  HomeCollectionCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import Foundation

protocol HomeCollectionCellViewModelProtocol {
    var title: String { get }
    var topicId: String { get }
}

class HomeCollectionCellViewModel: HomeCollectionCellViewModelProtocol {
    
    private var dataSource: Topic
    
    init(dataSource: Topic) {
        self.dataSource = dataSource
    }
    
    var title: String {
        dataSource.title ?? ""
    }
    
    var topicId: String {
        dataSource.id ?? ""
    }
}
