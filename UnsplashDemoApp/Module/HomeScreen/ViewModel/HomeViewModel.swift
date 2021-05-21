//
//  HomeViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func reloadTableData()
    func reloadCollectionData()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let router = Router<PhotoApi>()
    
    private var dataSource: [PhotoDisplayViewModel]
    private var selectedTopic: String?
    
    private var photoDataSource: [HomeTableCellViewModel] {
        didSet {
            self.delegate?.reloadTableData()
        }
    }
    
    private var topicDataSource: [HomeCollectionCellViewModel] {
        didSet {
            self.delegate?.reloadCollectionData()
        }
    }
    
    // MARK: - Initializer
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        self.photoDataSource = []
        self.topicDataSource = []
        self.dataSource = []
    }
    
    // MARK: - Get Topics
    func fetchTopicData(pageNo: Int) {
        router.request(PhotoApi.topicCollection(page: pageNo)) { (result: Result<[Topic], AppError>) in
            switch result {
            case .success(let data):
                self.topicDataSource.append(contentsOf: data.compactMap { HomeCollectionCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination Topics
    func extendingTopicData(pageNo: Int) {
        router.request(PhotoApi.topicCollection(page: pageNo)) { (result: Result<[Topic], AppError>) in
            switch result {
            case .success(let data):
                self.topicDataSource.append(contentsOf: data.compactMap { HomeCollectionCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Get Photos for a topic Id
    func fetchTopicPhotos(for topicId: String, pageNo: Int) {
        router.request(PhotoApi.topicPhotos(id: topicId, page: 1)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.selectedTopic = topicId
                self.photoDataSource.removeAll()
                self.dataSource.removeAll()
                self.photoDataSource.append(contentsOf: data.compactMap { HomeTableCellViewModel(dataSource: $0) })
                self.dataSource.append(contentsOf: data.compactMap { PhotoDisplayViewModel(photoData: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pagination Photos for a topic Id
    func extendingTopicPhotos(pageNo: Int) {
        guard let topicId = self.selectedTopic else { return }
        router.request(PhotoApi.topicPhotos(id: topicId, page: pageNo)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                self.photoDataSource.append(contentsOf: data.compactMap { HomeTableCellViewModel(dataSource: $0) })
                self.dataSource.append(contentsOf: data.compactMap { PhotoDisplayViewModel(photoData: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInTable(section: Int) -> Int {
        self.photoDataSource.count
    }
    
    func listDataForTable(at index: Int) -> HomeTableCellViewModel {
        self.photoDataSource[index]
    }
    
    func photoDataCount() -> Int {
        self.photoDataSource.count
    }
    
    func topicDataCount() -> Int {
        self.topicDataSource.count
    }
    
    func numberOfRowsInCollection(section: Int) -> Int {
        self.topicDataSource.count
    }
    
    func listDataForCollection(at index: Int) -> HomeCollectionCellViewModel {
        self.topicDataSource[index]
    }
    
    func selectedDataFromTable(at index: Int) -> PhotoDisplayViewModel? {
        self.dataSource[index]
    }
    
    func getPhotoId(at index: Int) -> String? {
        self.dataSource[index].photoModelId
    }
}
