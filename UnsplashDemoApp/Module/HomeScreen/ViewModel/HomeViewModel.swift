//
//  HomeViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/5/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let router = Router<PhotoApi>()
    
    private var dataSource: [HomeTableCellViewModel] {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    // MARK: - Initializer
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
        self.dataSource = []
    }
    
    func fetchData() {
        router.request(PhotoApi.photoCollection) { (result: Result<[Photo], AppError>) in
            switch result {
            case .success(let data):
                for items in data {
                    let filteredData = items.tags?.filter { item -> Bool in
                       item.source != nil
                    }
                    guard let newFilteredData = filteredData else { return }
                    self.dataSource.append(contentsOf: newFilteredData.compactMap { HomeTableCellViewModel(dataSource: $0) }
                    )
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        self.dataSource.count
    }
    
    func listData(at index: Int) -> HomeTableCellViewModel {
        self.dataSource[index]
    }
}
