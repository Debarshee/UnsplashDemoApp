//
//  PhotoViewViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Foundation

protocol PhotoViewViewModelProtocol {
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
}

class PhotoViewViewModel: PhotoViewViewModelProtocol {
    
    private var photoData: PhotoModel
    var photoID: String?
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
    
    func passUserData() -> UserDetailViewModel {
        UserDetailViewModel(userDataSource: photoData)
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
}
