//
//  HomeViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import Foundation

class HomeViewModel {
    
    let router = Router<PhotoApi>()
    
    func fetchData() {
        router.request(PhotoApi.photoCollection) { (result: Result<[Photo], AppError>) in
            switch result {
            case .success(let data):
                print(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
