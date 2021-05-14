//
//  UserTableCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import Foundation

protocol UserTableCellViewModelProtocol {
    var photoUrl: String { get }
}

class UserTableCellViewModel: UserTableCellViewModelProtocol {
    
    private var dataSource: PhotoModel
    
    init(dataSource: PhotoModel) {
        self.dataSource = dataSource
    }
    
    var photoUrl: String {
        dataSource.urls?.small ?? ""
    }
}
