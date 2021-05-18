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
    private var collectionId: String
    let router = Router<PhotoApi>()
    private var collectionDataSource: [CollectionDisplayCellViewModel] {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    
    init(collectionId: String) {
        self.collectionId = collectionId
        self.collectionDataSource = []
    }
    
    func getCollectionPhotos() {
        router.request(PhotoApi.collectionPhotos(id: collectionId)) { (result: Result<[PhotoModel], AppError>) in
            switch result {
            case .success(let data):
                print(data)
                self.collectionDataSource.append(contentsOf: data.compactMap { CollectionDisplayCellViewModel(dataSource: $0) })
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Pass Photo Data to Photo View Screen View Model
    func passPhotoData(photoData: PhotoModel) -> PhotoDisplayViewModel {
        PhotoDisplayViewModel(photoData: photoData)
    }
    
    func numberOfRowsForPhotosIn(section: Int) -> Int {
        self.collectionDataSource.count
    }
    
    func photoDataForCell(at index: Int) -> CollectionDisplayCellViewModel {
        self.collectionDataSource[index]
    }
}
