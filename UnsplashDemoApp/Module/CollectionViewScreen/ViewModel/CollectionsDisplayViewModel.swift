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
    private var collectionUsername: String
    let router = Router<PhotoApi>()
    private var collectionDataSource: [CollectionDisplayCellViewModel] {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    
    init(collectionUsername: String) {
        self.collectionUsername = collectionUsername
        self.collectionDataSource = []
    }
    
    func getCollectionPhotos() {
        router.request(PhotoApi.userCollection(username: collectionUsername)) { (result: Result<[PhotoModelUserCollection], AppError>) in
            switch result {
            case .success(let data):
                self.collectionDataSource.append(contentsOf: data.compactMap { CollectionDisplayCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsForPhotosIn(section: Int) -> Int {
        self.collectionDataSource.count
    }
    
    func photoDataForCell(at index: Int) -> CollectionDisplayCellViewModel {
        self.collectionDataSource[index]
    }
}
