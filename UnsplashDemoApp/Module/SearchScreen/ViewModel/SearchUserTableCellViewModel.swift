//
//  SearchUserTableCellViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import Foundation

protocol SearchUserTableCellViewModelProtocol {
    var name: String { get }
    var username: String { get }
    var profileImage: String { get }
    var firstSubImage: String { get }
    var secondSubImage: String { get }
    var thirdSubImage: String { get }
}

class SearchUserTableCellViewModel: SearchUserTableCellViewModelProtocol {

    private var dataSource: UnsplashUser
    
    init(dataSource: UnsplashUser) {
        self.dataSource = dataSource
    }
    
    var name: String {
        dataSource.name ?? ""
    }
    
    var username: String {
        "@\(dataSource.username ?? "")"
    }
    
    var profileImage: String {
        dataSource.profileImage?.small ?? ""
    }
    
    var firstSubImage: String {
        dataSource.photos?[0].urls?.small ?? ""
    }
    
    var secondSubImage: String {
        dataSource.photos?[1].urls?.small ?? ""
    }
    
    var thirdSubImage: String {
        dataSource.photos?[2].urls?.small ?? ""
    }
}
