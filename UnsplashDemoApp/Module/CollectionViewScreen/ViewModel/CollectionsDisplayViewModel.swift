//
//  CollectionsDisplayViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import Foundation

protocol CollectionsDisplayViewModelDelegate: AnyObject {
    func reloadTable()
}

class CollectionsDisplayViewModel {
    
    weak var delegate: CollectionsDisplayViewModelDelegate?
    let router = Router<PhotoApi>()
    private var photoDataSource: [CollectionDisplayCellViewModel] {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    
    init(delegate: CollectionsDisplayViewModelDelegate) {
        self.delegate = delegate
        self.photoDataSource = []
    }
    
    func getCollectionPhotos(for userName: String) {
        router.request(PhotoApi.userCollection(username: userName)) { (result: Result<[PhotoModelUserCollection], AppError>) in
            switch result {
            case .success(let data):
                self.photoDataSource.append(contentsOf: data.compactMap { CollectionDisplayCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsForPhotosIn(section: Int) -> Int {
        self.photoDataSource.count
    }
    
    func photoDataForCell(at index: Int) -> CollectionDisplayCellViewModel {
        self.photoDataSource[index]
    }
}
