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
    var selectedUsername: String?
    private var tableDataSource: [SearchTableCellViewModel] {
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
        self.tableDataSource = []
        self.collectionDataSource = []
        self.usersDataSource = []
    }
    
    func getSearchedPhotoData (for searchedText: String) {
        router.request(PhotoApi.searchPhotos(searchQuery: searchedText)) { (result: Result<SearchPhoto, AppError>) in
            switch result {
            case.success(let data):
                guard let finalData = data.results else { return }
                self.tableDataSource = finalData.compactMap { SearchTableCellViewModel(dataSource: $0) }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
    
    func passUserData(userData: UnsplashUser) -> UserDetailViewModel {
        UserDetailViewModel(userDataSource: userData)
    }
    
    func numberOfRowsInTable(section: Int) -> Int {
        self.tableDataSource.count
    }
    
    func listDataForTable(at index: Int) -> SearchTableCellViewModel {
        self.tableDataSource[index]
    }
    
    func numberOfRowsForCollectionIn(section: Int) -> Int {
        self.collectionDataSource.count
    }
    
    func collectionDataForCell(at index: Int) -> UserCollectionTableViewCellViewModel {
        self.collectionDataSource[index]
    }
    
    func numberOfRowsForUsersIn(section: Int) -> Int {
        self.usersDataSource.count
    }
    
    func usersDataForCell(at index: Int) -> SearchUserTableCellViewModel {
        self.usersDataSource[index]
    }
}
