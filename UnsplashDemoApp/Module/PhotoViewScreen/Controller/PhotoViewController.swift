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
    
    var photoViewViewModel: PhotoViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.downloadImage(with: photoViewViewModel?.photoImage)
        userButton.setTitle(photoViewViewModel?.photoUser, for: .normal)
    }
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func userButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let userDetailViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else { return }
        userDetailViewController.userDetailViewModel = photoViewViewModel?.passUserData()
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
    
    @IBAction private func photoInfoButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoInfoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoInfoViewController") as? PhotoInfoViewController else { return }
        self.present(photoInfoViewController, animated: true, completion: nil)
    }
}
