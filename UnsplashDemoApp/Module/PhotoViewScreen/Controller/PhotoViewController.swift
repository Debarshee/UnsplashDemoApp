//
//  PhotoViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var userButton: UIButton!
    @IBOutlet private weak var photoInfoButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var addPhotoToProfileButton: UIButton!
    @IBOutlet private weak var downloadButton: UIButton!
    
    var photoDisplayViewModel: PhotoDisplayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDisplayViewModel?.getPhotoData()
        guard let userData = photoDisplayViewModel?.photoUsername else { return }
        photoDisplayViewModel?.getUserData(userName: userData)
        photoImageView.downloadImage(with: photoDisplayViewModel?.photoImage)
        userButton.setTitle(photoDisplayViewModel?.photoUser, for: .normal)
    }
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func userButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let userDetailViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else { return }
        guard let data = photoDisplayViewModel?.passUserData() else { return }
        userDetailViewController.userDetailViewModel = data
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
    
    @IBAction private func photoInfoButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoInfoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoInfoViewController") as? PhotoInfoViewController else { return }
        guard let photoData = photoDisplayViewModel?.photo else { return }
        let photo = PhotoDisplayViewModel(photoData: photoData)
        photoInfoViewController.photoViewModel = photo
        photoInfoViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(photoInfoViewController, animated: true, completion: nil)
    }
    
    @IBAction private func shareButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func likeButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(loginViewController, animated: true, completion: nil)
    }
    @IBAction private func addPhotoToProfileButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(loginViewController, animated: true, completion: nil)
    }
    @IBAction private func downloadButtonClicked(_ sender: UIButton) {
        if let url = URL(string: photoDisplayViewModel?.photoImage ?? ""),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}
