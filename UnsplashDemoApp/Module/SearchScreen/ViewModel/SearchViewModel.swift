//
//  SearchViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reload()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    let router = Router<PhotoApi>()
    private var tableDataSource: [SearchTableCellViewModel] {
        didSet {
            self.delegate?.reload()
        }
    }
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        self.tableDataSource = []
    }
    
    func getSearchedData (for searchedText: String) {
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
    
    func numberOfRowsInTable(section: Int) -> Int {
        self.tableDataSource.count
    }
    
    func listDataForTable(at index: Int) -> SearchTableCellViewModel {
        self.tableDataSource[index]
    }
}
