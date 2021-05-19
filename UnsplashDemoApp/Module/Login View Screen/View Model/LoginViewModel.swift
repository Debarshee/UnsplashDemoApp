//
//  LoginViewModel.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/18/21.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func userDataFetched(user: UserDetailViewModel)
}

class LoginViewModel {
    
    var userData: UserDetailViewModel?
    let router = Router<PhotoApi>()
    weak var delegate: LoginViewModelDelegate?
    
    func getUserData(userName: String) {
        router.request(PhotoApi.userInfo(username: userName)) { [weak self] (result: Result<UnsplashUser, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userData = UserDetailViewModel(userDataSource: data)
                if let user = self.userData {
                    self.delegate?.userDataFetched(user: user)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
