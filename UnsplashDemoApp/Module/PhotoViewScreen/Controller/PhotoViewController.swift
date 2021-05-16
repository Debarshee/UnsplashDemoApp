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
    
    var photoDisplayViewModel: PhotoDisplayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDisplayViewModel?.getPhotoData()
        photoImageView.downloadImage(with: photoDisplayViewModel?.photoImage)
        userButton.setTitle(photoDisplayViewModel?.photoUser, for: .normal)
        guard let userData = photoDisplayViewModel?.photoUsername else { return }
        photoDisplayViewModel?.getUserData(userName: userData)
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
        self.present(photoInfoViewController, animated: true, completion: nil)
    }
}
