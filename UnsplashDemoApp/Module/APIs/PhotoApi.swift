//
//  PhotoApi.swift
//  OperationsDemoApp
//
//  Created by Debarshee on 5/3/21.
//

import Foundation

enum PhotoApi {
    case photoCollection
    case topicCollection(page: Int)
    case topicPhotos(id: String, page: Int)
    case userPhotos(username: String, page: Int)
    case userCollection(username: String, page: Int)
    case userLikes(username: String, page: Int)
    case searchPhotos(searchQuery: String)
    case searchCollections(searchQuery: String)
    case searchUsers(searchQuery: String)
    case photoInfo(id: String)
    case userInfo(username: String)
    case collectionPhotos(id: String)
}

extension PhotoApi: EndPoint {
    
    var path: String {
        switch self {
        case .photoCollection:
            return "collections/"
            
        case .topicCollection:
            return "topics/"
        
        case let .topicPhotos(id, _):
            return "topics/\(id)/photos"
        
        case let .userPhotos(username, _):
            return "users/\(username)/photos"
            
        case let .userCollection(username, _):
            return "users/\(username)/collections"
        
        case let .userLikes(username, _):
            return "users/\(username)/likes"
            
        case .searchPhotos:
            return "search/photos"
            
        case .searchCollections:
            return "search/collections"
            
        case .searchUsers:
            return "search/users"
            
        case .photoInfo(let id):
            return "photos/\(id)"
            
        case .userInfo(let username):
            return "users/\(username)"
            
        case .collectionPhotos(let id):
            return "collections/\(id)/photos"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .photoCollection:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .topicCollection(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case let .topicPhotos(_, page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
        
        case let .userPhotos(_, page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
        
        case let .userCollection(_, page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
        
        case let .userLikes(_, page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .searchPhotos(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .searchCollections(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .searchUsers(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
        
        case .photoInfo:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .userInfo:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
            
        case .collectionPhotos:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": ApiConfiguration.apiKey1
                                      ]
            )
        }
    }
}
