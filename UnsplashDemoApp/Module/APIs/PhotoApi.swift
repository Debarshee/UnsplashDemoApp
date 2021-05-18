//
//  PhotoApi.swift
//  OperationsDemoApp
//
//  Created by Debarshee on 5/3/21.
//

import Foundation

enum PhotoApi {
    case photoCollection
    case topicCollection
    case topicPhotos(id: String)
    case userPhotos(username: String)
    case userCollection(username: String)
    case userLikes(username: String)
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
        
        case .topicPhotos(let id):
            return "topics/\(id)/photos"
        
        case .userPhotos(let username):
            return "users/\(username)/photos"
            
        case .userCollection(let username):
            return "users/\(username)/collections"
        
        case .userLikes(let username):
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
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .topicCollection:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .topicPhotos:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
        
        case .userPhotos:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
        
        case .userCollection:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
        
        case .userLikes:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .searchPhotos(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .searchCollections(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .searchUsers(let searchQuery):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "query": searchQuery,
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
        
        case .photoInfo:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .userInfo:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
            
        case .collectionPhotos:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "client_id": "EcTvZyV0lF8VFzRRqY1YarOpwtxxID8VFudpRV8rd6g"
                                      ]
            )
        }
    }
}
