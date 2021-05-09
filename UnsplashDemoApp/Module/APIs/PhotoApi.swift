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
        }
    }
}
