//
//  SearchViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reloadTableData()
}

class SearchViewModel {
    
    // MARK: - Properties
    weak var delegate: SearchViewModelDelegate?
    let router = Router<PhotoApi>()
    private var photoDataSource: [SearchTableCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    private var collectionDataSource: [UserCollectionTableViewCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    private var usersDataSource: [SearchUserTableCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        self.photoDataSource = []
        self.collectionDataSource = []
        self.usersDataSource = []
    }
    
    // MARK: - Get Photo Data from url endpoint
    func getSearchedPhotoData (for searchedText: String) {
        router.request(PhotoApi.searchPhotos(searchQuery: searchedText)) { (result: Result<SearchPhoto, AppError>) in
            switch result {
            case.success(let data):
                guard let finalData = data.results else { return }
                self.photoDataSource = finalData.compactMap { SearchTableCellViewModel(dataSource: $0) }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Get User Data from url endpoint
    func getSearchedUsersData (for searchedText: String) {
        router.request(PhotoApi.searchUsers(searchQuery: searchedText)) { (result: Result<UserCollection, AppError>) in
            switch result {
            case.success(let data):
                guard let finalData = data.results else { return }
                self.usersDataSource = finalData.compactMap { SearchUserTableCellViewModel(dataSource: $0) }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Get Collection Data from url endpoint
    func getSearchedCollectionData (for searchedText: String) {
        router.request(PhotoApi.searchCollections(searchQuery: searchedText)) { (result: Result<SearchCollection, AppError>) in
            switch result {
            case.success(let data):
                guard let finalData = data.results else { return }
                self.collectionDataSource = finalData.compactMap { UserCollectionTableViewCellViewModel(dataSource: $0) }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pass User Data to User Detail Screen View Model
    func passPhotoData(photoData: PhotoModel) -> PhotoDisplayViewModel {
        PhotoDisplayViewModel(photoData: photoData)
    }
    
    // MARK: - Pass User Data to User Detail Screen View Model
    func passUserData(userData: UnsplashUser) -> UserDetailViewModel {
        UserDetailViewModel(userDataSource: userData)
    }
    
    // MARK: - Pass Collection Data to Collection Display Screen View Model
    func passCollectionData(collectionData: String) -> CollectionsDisplayViewModel {
        CollectionsDisplayViewModel(collectionUsername: collectionData)
    }
    
    // MARK: - For Photo Cells
    func numberOfRowsInTable(section: Int) -> Int {
        self.photoDataSource.count
    }
    
    func photoDataForCell(at index: Int) -> SearchTableCellViewModel {
        self.photoDataSource[index]
    }
    
    // MARK: - For Collection Cells
    func numberOfRowsForCollectionIn(section: Int) -> Int {
        self.collectionDataSource.count
    }
    
    func collectionDataForCell(at index: Int) -> UserCollectionTableViewCellViewModel {
        self.collectionDataSource[index]
    }
    
    // MARK: - For User Cells
    func numberOfRowsForUsersIn(section: Int) -> Int {
        self.usersDataSource.count
    }
    
    func usersDataForCell(at index: Int) -> SearchUserTableCellViewModel {
        self.usersDataSource[index]
    }
}
