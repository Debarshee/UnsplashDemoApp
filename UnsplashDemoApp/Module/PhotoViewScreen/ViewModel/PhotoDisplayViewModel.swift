//
//  PhotoDisplayViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Firebase
import FirebaseDatabase
import Foundation
import MapKit

protocol PhotoDisplayViewModelProtocol {
    var photoImage: String { get }
    var photoUser: String { get }
    var photo: PhotoModel { get }
    var photoMake: String { get }
    var photoModel: String { get }
    var photoAperture: String { get }
    var photoShutterSpeed: String { get }
    var photoFocalLength: String { get }
    var photoISO: String { get }
    var photoLocation: String { get }
    var photoDescription: String { get }
    var photoModelId: String { get }
    var photoUsername: String { get }
}

class PhotoDisplayViewModel: PhotoDisplayViewModelProtocol {
    
    var ref: DocumentReference?
    let db = Firestore.firestore()
    var profilePhotos: [String] = []
    var profileLikedPhotos: [String] = []
    private var photoData: PhotoModel
    private var userData: UnsplashUser?
    var photoId: String?
    let router = Router<PhotoApi>()
    
    init(photoData: PhotoModel) {
        self.photoData = photoData
    }
    
    var photoImage: String {
        photoData.urls?.small ?? ""
    }
    
    var photoUser: String {
        self.photoData.user?.name ?? ""
    }
    
    var photo: PhotoModel {
        photoData
    }
    
    var photoMake: String {
        self.photoData.exif?.make ?? ""
    }
    
    var photoModel: String {
        self.photoData.exif?.model ?? ""
    }
    
    var photoAperture: String {
        self.photoData.exif?.aperture ?? ""
    }
    
    var photoShutterSpeed: String {
        self.photoData.exif?.exposureTime ?? ""
    }
    
    var photoFocalLength: String {
        self.photoData.exif?.focalLength ?? ""
    }
    
    var photoISO: String {
        String(self.photoData.exif?.iso ?? 0)
    }
    
    var photoDimension: String {
        "\(String(self.photoData.height ?? 0))x\(String(self.photoData.width ?? 0))"
    }
    
    var photoPublishedDate: String {
        self.photoData.updatedAt ?? self.photoData.promotedAt ?? ""
    }
    
    var photoLocation: String {
        guard let locationCountry = self.photoData.location?.country else {
            return ""
        }
        if locationCountry.isEmpty {
            return ""
        } else {
            return "\(self.photoData.location?.name ?? ""), \(self.photoData.location?.city ?? ""), \(locationCountry)"
        }
    }
    
    var photoDescription: String {
        self.photoData.description ?? self.photoData.altDescription ?? ""
    }
    
    var photoModelId: String {
        self.photoData.id ?? ""
    }
    
    var photoUsername: String {
        self.photoData.user?.username ?? ""
    }
    
    func passUserData() -> UserDetailViewModel {
        guard let data = userData else {
            fatalError("Invalid data")
        }
        return UserDetailViewModel(userDataSource: data)
    }
    
    func setAnnotation(on mapView: MKMapView) {
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(photoData.location?.position?.latitude ?? 0),
                                                longitude: CLLocationDegrees(photoData.location?.position?.longitude ?? 0))
        annotation.title = self.photoData.location?.name ?? ""
        annotation.coordinate = coordinate
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func getPhotoData() {
        guard let photoId = self.photoData.id else { return }
        router.request(PhotoApi.photoInfo(id: photoId)) { (result: Result<PhotoModel, AppError>) in
            switch result {
            case .success(let data):
                self.photoData = data
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserData(userName: String) {
        router.request(PhotoApi.userInfo(username: userName)) { (result: Result<UnsplashUser, AppError>) in
            switch result {
            case .success(let data):
                self.userData = data
            
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
                                if let photoArray = dict["photoIds"] as? [String], let likedPhotoArray = dict["likedPhotos"] as? [String] {
                                    self.profilePhotos = photoArray
                                    self.profileLikedPhotos = likedPhotoArray
                                }
                            }
                        }
                    }
            }
        }
    }
    
    func addPhotoToProfile(profile: FirebaseAuth.User) {
        profilePhotos.append(photo.id ?? "")
        db.collection("Users").document(profile.uid).setData([
            "photoIds": profilePhotos,
            "addedByUser": profile.uid,
            "likedPhotos": profileLikedPhotos
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func addLikedPhotoToProfile(profile: FirebaseAuth.User) {
        profileLikedPhotos.append(photo.id ?? "")
        db.collection("Users").document(profile.uid).setData([
            "photoIds": profilePhotos,
            "addedByUser": profile.uid,
            "likedPhotos": profileLikedPhotos
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
