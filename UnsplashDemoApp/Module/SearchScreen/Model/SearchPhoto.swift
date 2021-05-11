//
//  SearchPhoto.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import Foundation

class SearchPhoto: Decodable {
    var total: Int?
    var totalPages: Int?
    var results: [TopicPhoto]?
    
    enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}
