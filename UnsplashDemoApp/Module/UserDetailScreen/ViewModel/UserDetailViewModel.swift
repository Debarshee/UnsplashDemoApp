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
    
    // MARK: - Properties
    let router = Router<PhotoApi>()
    weak var delegate: UserDetailViewModelDelegate?
    private var userDataSource: UnsplashUser
    
    private var dataSource: [UserTableCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    private var collectionDataSource: [UserCollectionTableViewCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    // MARK: - Initializers
    init(userDataSource: UnsplashUser) {
        self.userDataSource = userDataSource
        self.dataSource = []
        self.collectionDataSource = []
    }
    
    // MARK: - Public Functions
    func getUserFullName() -> String {
        self.userDataSource.name ?? ""
    }
    
    func getUserImage() -> String {
        var image = ""
        if (self.userDataSource.photos?.count ?? 0) > 0 {
            image = self.userDataSource.photos?[0].urls?.small ?? ""
        }
        return image
    }
    
    func getUserLocation() -> String {
        self.userDataSource.location ?? ""
    }
    
    func getUserLink() -> String {
        self.userDataSource.portfolioUrl ?? ""
    }
    
    func getUserProfileImage() -> String {
        self.userDataSource.profileImage?.small ?? ""
    }
    
    func getUsername() -> String {
        self.userDataSource.username ?? ""
    }
    
    // MARK: - Get Photos Data
    func getUserPhotos(pageNo: Int) {
        router.request(PhotoApi.userPhotos(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: data.compactMap { UserTableCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination Photos Data
    func extendedUserPhotos(pageNo: Int) {
        router.request(PhotoApi.userPhotos(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.append(contentsOf: data.compactMap { UserTableCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Get Collection Data
    func getUserCollections(pageNo: Int) {
        router.request(PhotoApi.userCollection(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModelUserCollection], AppError>) in
            switch result {
            case .success(let data):
                self.collectionDataSource.append(contentsOf: data.compactMap { UserCollectionTableViewCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination Collection Data
    func extendedUserCollections(pageNo: Int) {
        router.request(PhotoApi.userCollection(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModelUserCollection], AppError>) in
            switch result {
            case .success(let data):
                self.collectionDataSource.append(contentsOf: data.compactMap { UserCollectionTableViewCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Get Likes Data
    func getUserLikes(pageNo: Int) {
        router.request(PhotoApi.userLikes(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: data.compactMap { UserTableCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination Likes Data
    func extendedUserLikes(pageNo: Int) {
        router.request(PhotoApi.userLikes(username: getUsername(), page: pageNo)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.append(contentsOf: data.compactMap { UserTableCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pass Photo Data to Photo View Screen View Model
    func passPhotoData(photoData: PhotoModel) -> PhotoDisplayViewModel {
        PhotoDisplayViewModel(photoData: photoData)
    }
    
    // MARK: - Pass Collection Data to Collection Display Screen View Model
    func passCollectionData(collectionData: String) -> CollectionsDisplayViewModel {
        CollectionsDisplayViewModel(collectionId: collectionData)
    }
    
    // MARK: - table rows for photo and likes
    func numberOfRowsIn() -> Int {
        self.dataSource.count
    }
    
    func dataForCell(at index: Int) -> UserTableCellViewModel {
        self.dataSource[index]
    }
    
    func numberOfRowsForCollectionIn() -> Int {
        self.collectionDataSource.count
    }
    
    func collectionDataForCell(at index: Int) -> UserCollectionTableViewCellViewModel {
        self.collectionDataSource[index]
    }
}
