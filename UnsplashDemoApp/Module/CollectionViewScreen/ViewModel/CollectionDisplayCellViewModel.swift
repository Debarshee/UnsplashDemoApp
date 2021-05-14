//
//  CollectionDisplayCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import Foundation

protocol CollectionDisplayCellViewModelProtocol {
    var photoImage: String { get }
}

class CollectionDisplayCellViewModel: CollectionDisplayCellViewModelProtocol {
    
    private var dataSource: PhotoModelUserCollection
    
    init(dataSource: PhotoModelUserCollection) {
        self.dataSource = dataSource
    }
    
    var photoImage: String {
        dataSource.coverPhoto?.urls?.small ?? ""
    }
}
