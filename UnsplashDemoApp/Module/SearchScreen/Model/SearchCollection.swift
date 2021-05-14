//
//  SearchCollection.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import Foundation

class SearchCollection: Decodable {
    var total: Int?
    var totalPages: Int?
    var results: [PhotoModelUserCollection]?
    
    enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}
