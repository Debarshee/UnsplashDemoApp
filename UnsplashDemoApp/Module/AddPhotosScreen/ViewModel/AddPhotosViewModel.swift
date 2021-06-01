//
//  AddPhotosViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import Firebase
import Foundation

protocol AddPhotosViewModelDelegate: AnyObject {
    func reload()
}

class AddPhotosViewModel {
    
    var ref: DocumentReference?
    let db = Firestore.firestore()
    var profilePhotos: [String] = []
    var profileLikedPhotos: [String] = []
    var profileUploadedPhotos: [String] = []
    var userId = ""
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
                                if let photoArray = dict["photoIds"] as? [String],
                                   let likedPhotoArray = dict["likedPhotos"] as? [String],
                                   let uploadPhotoArray = dict["userUploadedPhotos"] as? [String] {
                                    self.profilePhotos = photoArray
                                    self.profileLikedPhotos = likedPhotoArray
                                    self.profileUploadedPhotos = uploadPhotoArray
                                }
                            }
                        }
                    }
            }
        }
    }
    // MARK: Add uploaded image to firestore
    func addUploadedPhotoToProfile(imageUrl: String) {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                self.userId = user?.uid ?? ""
                self.profileUploadedPhotos.append(imageUrl)
                self.db.collection("Users").document(user?.uid ?? "").setData([
                    "photoIds": self.profilePhotos,
                    "addedByUser": self.userId,
                    "likedPhotos": self.profileLikedPhotos,
                    "userUploadedPhotos": self.profileUploadedPhotos
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    // MARK: - Upload Image to Firebase Storage
    func uploadMedia(selectedImage: UIImage?, completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("myImage.png")
        guard let image = selectedImage else { return }
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil) { [weak self] _, error in
                guard let self = self else { return }
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL { url, _ in
                        self.addUploadedPhotoToProfile(imageUrl: url?.absoluteString ?? "")
                    }
                }
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
