//
//  UserDetailViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userLocationLabel: UILabel!
    @IBOutlet private weak var userLocationImageView: UIImageView!
    @IBOutlet private weak var userLinkLabel: UILabel!
    @IBOutlet private weak var userLinkImageView: UIImageView!
    @IBOutlet private weak var userProfileImageView: UIImageView!
    @IBOutlet private weak var userSegmentControl: UISegmentedControl!
    @IBOutlet private weak var backButton: UIButton!
    
    @IBOutlet private weak var userTableView: UITableView! {
        didSet {
            self.userTableView.dataSource = self
        }
    }
    
    var userDetailViewModel: UserDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = userDetailViewModel?.getUserFullName()
        userImageView.downloadImage(with: userDetailViewModel?.getUserImage())
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = userImageView.bounds
        userImageView.addSubview(blurView)
        userProfileImageView.downloadImage(with: userDetailViewModel?.getUserProfileImage())
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        userProfileImageView.clipsToBounds = true
        if userDetailViewModel?.getUserLocation() == "" {
            userLocationLabel.isHidden = true
            userLocationImageView.isHidden = true
        } else {
            userLocationLabel.text = userDetailViewModel?.getUserLocation()
        }
        
        if userDetailViewModel?.getUserLink() == "" {
            userLinkLabel.isHidden = true
            userLinkImageView.isHidden = true
        } else {
            userLinkLabel.text = userDetailViewModel?.getUserLink()
        }
        
        switch userSegmentControl.selectedSegmentIndex {
        case 0:
            userDetailViewModel?.getUserPhotos()
            
        case 1:
            userDetailViewModel?.getUserLikes()
        
        case 2:
            userDetailViewModel?.getUserCollections()
            
        default:
            break
        }
    }
    
    @IBAction private func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
