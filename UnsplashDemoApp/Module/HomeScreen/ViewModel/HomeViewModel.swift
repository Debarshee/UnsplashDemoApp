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
    
    private var dataSource: [PhotoViewViewModel]
    
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
    
//    func fetchPhotoData() {
//        router.request(PhotoApi.photoCollection) { (result: Result<[Photo], AppError>) in
//            switch result {
//            case .success(let data):
//                for items in data {
//                    let filteredData = items.tags?.filter { item -> Bool in
//                       item.source != nil
//                    }
//                    guard let newFilteredData = filteredData else { return }
//                    self.photoDataSource.append(contentsOf: newFilteredData.compactMap { HomeTableCellViewModel(dataSource: $0) }
//                    )
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func fetchTopicData() {
        router.request(PhotoApi.topicCollection) { (result: Result<[Topic], AppError>) in
            switch result {
            case .success(let data):
                self.topicDataSource.append(contentsOf: data.compactMap { HomeCollectionCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopicPhotos(for topicId: String) {
        router.request(PhotoApi.topicPhotos(id: topicId)) { (result: Result<[TopicPhoto], AppError>) in
            switch result {
            case .success(let data):
                self.photoDataSource.removeAll()
                self.dataSource.removeAll()
                self.photoDataSource.append(contentsOf: data.compactMap { HomeTableCellViewModel(dataSource: $0) })
                self.dataSource.append(contentsOf: data.compactMap { PhotoViewViewModel(photoData: $0) })
                
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
    
    func numberOfRowsInCollection(section: Int) -> Int {
        self.topicDataSource.count
    }
    
    func listDataForCollection(at index: Int) -> HomeCollectionCellViewModel {
        self.topicDataSource[index]
    }
    
    func selectedDataFromTable(at index: Int) -> PhotoViewViewModel? {
//        let data = self.dataSource[index]
//        let topicPhotoData = PhotoViewViewModel(photoData: data)
//        return topicPhotoData
        
        self.dataSource[index]
    }
}
