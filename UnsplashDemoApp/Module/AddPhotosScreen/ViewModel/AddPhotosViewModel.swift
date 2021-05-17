//
//  AddPhotosViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import Foundation

protocol AddPhotosViewModelDelegate: AnyObject {
    func reload()
}

class AddPhotosViewModel {
    
    weak var delegate: AddPhotosViewModelDelegate?
    private var blogDataSource: [BlogCollectionCellViewModel] {
        didSet {
            self.delegate?.reload()
        }
    }
    let router = Router<PhotoApi>()
    
    init(delegate: AddPhotosViewModelDelegate) {
        self.delegate = delegate
        self.blogDataSource = []
    }
    
    func getCollectionData() {
        router.request(PhotoApi.photoCollection) { (result: Result<[BlogPhotos], AppError>) in
            switch result {
            case .success(let data):
                self.blogDataSource.append(contentsOf: data.compactMap { BlogCollectionCellViewModel(dataSource: $0) })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInCollection(section: Int) -> Int {
        self.blogDataSource.count
    }
    
    func listDataForCollection(at index: Int) -> BlogCollectionCellViewModel {
        self.blogDataSource[index]
    }
}
