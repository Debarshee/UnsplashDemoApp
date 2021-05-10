//
//  UserDetailViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Foundation

protocol UserDetailViewModelDelegate: AnyObject {
    func reloadTableData()
}

class UserDetailViewModel {
    
    let router = Router<PhotoApi>()
    private var userDataSource: TopicPhoto
    weak var delegate: UserDetailViewModelDelegate?
    
    private var dataSource: [TopicPhoto] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    init(userDataSource: TopicPhoto) {
        self.userDataSource = userDataSource
        self.dataSource = []
    }
    
    func getUserFullName() -> String {
        self.userDataSource.user?.name ?? ""
    }
    
    func getUserImage() -> String {
        self.userDataSource.urls?.small ?? ""
    }
    
    func getUserLocation() -> String {
        self.userDataSource.user?.location ?? ""
    }
    
    func getUserLink() -> String {
        self.userDataSource.user?.portfolioUrl ?? ""
    }
    
    func getUserProfileImage() -> String {
        self.userDataSource.user?.profileImage?.medium ?? ""
    }
    
    func getUsername() -> String {
        self.userDataSource.user?.username ?? ""
    }
    
    func getUserPhotos() {
        router.request(PhotoApi.userPhotos(username: getUsername())) { (result: Result<[TopicPhoto], AppError>) in
            switch result {
            case .success(let data):
                print(data)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserCollections() {
        router.request(PhotoApi.userCollection(username: getUsername())) { (result: Result<[TopicPhoto], AppError>) in
            switch result {
            case .success(let data):
                print(data)
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserLikes() {
        router.request(PhotoApi.userLikes(username: getUsername())) { (result: Result<[TopicPhoto], AppError>) in
            switch result {
            case .success(let data):
                print(data)
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
