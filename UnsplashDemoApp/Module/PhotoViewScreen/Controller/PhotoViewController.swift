//
//  PhotoViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import Firebase
import FirebaseDatabase
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
        photoDisplayViewModel?.getPhotoDataFromFireBase()
        guard let userData = photoDisplayViewModel?.photoUsername else { return }
        photoDisplayViewModel?.getUserData(userName: userData)
        photoImageView.downloadImage(with: photoDisplayViewModel?.photoImage)
        userButton.setTitle(photoDisplayViewModel?.photoUser, for: .normal)
    }
    
    // MARK: - Close Photo View
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - User name Clicked
    @IBAction private func userButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let userDetailViewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else { return }
        guard let data = photoDisplayViewModel?.passUserData() else { return }
        userDetailViewController.userDetailViewModel = data
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
    
    // MARK: - Info Button Clicked
    @IBAction private func photoInfoButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let photoInfoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoInfoViewController") as? PhotoInfoViewController else { return }
        guard let photoData = photoDisplayViewModel?.photo else { return }
        let photo = PhotoDisplayViewModel(photoData: photoData)
        photoInfoViewController.photoViewModel = photo
        photoInfoViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(photoInfoViewController, animated: true, completion: nil)
    }
    // MARK: - Share Button Clicked
    @IBAction private func shareButtonClicked(_ sender: UIButton) {
    }
    // MARK: - Like Button Clicked
    @IBAction private func likeButtonClicked(_ sender: UIButton) {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                guard let unwrappedUser = user else { return }
                self.photoDisplayViewModel?.addLikedPhotoToProfile(profile: unwrappedUser)
            } else {
                let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
    }
    // MARK: - Add Button Clicked
    @IBAction private func addPhotoToProfileButtonClicked(_ sender: UIButton) {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                guard let unwrappedUser = user else { return }
                self.photoDisplayViewModel?.addPhotoToProfile(profile: unwrappedUser)
            } else {
                let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
    }
    // MARK: - Download Button Clicked
    @IBAction private func downloadButtonClicked(_ sender: UIButton) {
        if let url = URL(string: photoDisplayViewModel?.photoImage ?? ""),
           let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) {
               UIImageWriteToSavedPhotosAlbum(image,
                                              self,
                                              #selector(saveError(_:didFinishSavingWithError:contextInfo:)),
                                              nil)
           }
    }
    
    @objc
    func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "Image Downloaded", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
