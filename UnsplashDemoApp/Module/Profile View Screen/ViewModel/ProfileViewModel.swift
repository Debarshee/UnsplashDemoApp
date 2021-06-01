//
//  ProfileViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/22/21.
//

import Firebase
import FirebaseDatabase
import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func reloadTable()
}

class ProfileViewModel {
    
    var ref: DocumentReference?
    let db = Firestore.firestore()
    private var photoDataSource: [ProfileTableCellViewModel] {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    private var likedPhotoDataSource: [ProfileTableCellViewModel] {
        didSet {
            self.delegate?.reloadTable()
        }
    }
    weak var delegate: ProfileViewModelDelegate?
    let router = Router<PhotoApi>()
    
    init(delegate: ProfileViewModelDelegate?) {
        self.delegate = delegate
        photoDataSource = []
        likedPhotoDataSource = []
    }
    
    func getPhotoDataFromFireBase() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                self.db.collection("Users")
                    .document(user?.uid ?? "" )
                    .getDocument { document, error in
                        if let unwrappedError = error {
                            print("Error \(unwrappedError)")
                        } else {
                            if let snapshotDocument = document {
                                let dicts = snapshotDocument.data()
                                guard let dict = dicts else { return }
                                if let photoArray = dict["photoIds"] as? [String], let likedPhotoArray = dict["likedPhotos"] as? [String] {
                                    for id in photoArray {
                                        self.getPhotos(from: id)
                                    }
                                    for id in likedPhotoArray {
                                        self.getLikedPhotos(from: id)
                                    }
                                }
                            }
                        }
                    }
            }
        }
    }
    
    func getPhotos(from photoId: String) {
        self.photoDataSource.removeAll()
        router.request(PhotoApi.photoInfo(id: photoId)) { (result: Result<PhotoModel, AppError>) in
            switch result {
            case .success(let data):
                self.photoDataSource.append(ProfileTableCellViewModel(dataSource: data))
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getLikedPhotos(from photoId: String) {
        self.likedPhotoDataSource.removeAll()
        router.request(PhotoApi.photoInfo(id: photoId)) { (result: Result<PhotoModel, AppError>) in
            switch result {
            case .success(let data):
                self.likedPhotoDataSource.append(ProfileTableCellViewModel(dataSource: data))
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowForPhotos() -> Int {
        self.photoDataSource.count
    }
    
    func numberOfRowForLikedPhotos() -> Int {
        self.likedPhotoDataSource.count
    }
    
    func dataForPhotoCell(at index: Int) -> ProfileTableCellViewModel {
        self.photoDataSource[index]
    }
    
    func dataForLikeCell(at index: Int) -> ProfileTableCellViewModel {
        self.likedPhotoDataSource[index]
    }
}
