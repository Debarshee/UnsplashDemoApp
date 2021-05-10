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
    private var userDataSource: TopicPhoto
    weak var delegate: UserDetailViewModelDelegate?
    
    private var dataSource: [UserTableCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    // MARK: - Initializers
    init(userDataSource: TopicPhoto) {
        self.userDataSource = userDataSource
        self.dataSource = []
    }
    
    // MARK: - Public Functions
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
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: data.compactMap({ item -> UserTableCellViewModel? in
                    let userDetail = UserDetail(userImage: item.urls?.small ?? "",
                                                userFullName: self.getUserFullName(),
                                                imageTitle: item.description ?? item.altDescription ?? "",
                                                imageOwnerName: item.user?.name ?? "")
                    return UserTableCellViewModel(dataSource: userDetail)
                }))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserCollections() {
        router.request(PhotoApi.userCollection(username: getUsername())) { (result: Result<[Photo], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.removeAll()
                for items in data {
                    let filteredData = items.tags?.filter { item -> Bool in
                       item.source != nil
                    }
                    guard let newFilteredData = filteredData else { return }
                    
                    // Configuring Photo object to PhotoData Object within ListCellViewModel
                    self.dataSource.append(contentsOf: newFilteredData.compactMap({ item -> UserTableCellViewModel? in
                        let userDetail = UserDetail(userImage: item.source?.coverPhoto?.urls?.small,
                                                    userFullName: self.getUserFullName(),
                                                    imageTitle: item.source?.coverPhoto?.description ?? item.source?.coverPhoto?.altDescription,
                                                    imageOwnerName: item.source?.coverPhoto?.user?.name)
                        return UserTableCellViewModel(dataSource: userDetail)
                    }))
                }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserLikes() {
        router.request(PhotoApi.userLikes(username: getUsername())) { (result: Result<[TopicPhoto], AppError>) in
            switch result {
            case .success(let data):
                self.dataSource.removeAll()
                self.dataSource.append(contentsOf: data.compactMap({ item -> UserTableCellViewModel? in
                    let userDetail = UserDetail(userImage: item.urls?.small ?? "",
                                                userFullName: self.getUserFullName(),
                                                imageTitle: item.description ?? item.altDescription ?? "",
                                                imageOwnerName: item.user?.name ?? "")
                    return UserTableCellViewModel(dataSource: userDetail)
                }))
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        self.dataSource.count
    }
    
    func dataForCell(at index: Int) -> UserTableCellViewModel {
        self.dataSource[index]
    }
}
