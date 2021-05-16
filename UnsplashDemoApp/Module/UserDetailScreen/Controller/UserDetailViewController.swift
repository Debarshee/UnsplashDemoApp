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
            self.userTableView.delegate = self
            self.userTableView.register(UINib(nibName: UserCollectionTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: UserCollectionTableViewCell.identifier)
        }
    }
    
    var userDetailViewModel: UserDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailViewModel?.delegate = self
        userNameLabel.text = userDetailViewModel?.getUserFullName()
        userImageView.downloadImage(with: userDetailViewModel?.getUserImage())
        
        // Blur effect to image view
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = userImageView.bounds
        userImageView.addSubview(blurView)
        userProfileImageView.downloadImage(with: userDetailViewModel?.getUserProfileImage())
        
        // Set Circular bounds to profile image
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        userProfileImageView.clipsToBounds = true
        
        // Set text color for segmented control
        userSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        userSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        if userDetailViewModel?.getUserLocation() == "" {
            userLocationLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            userLocationImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            userLocationLabel.text = userDetailViewModel?.getUserLocation()
        }
        
        if userDetailViewModel?.getUserLink() == "" {
            userLinkLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            userLinkImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            userLinkLabel.text = userDetailViewModel?.getUserLink()
        }
        userDetailViewModel?.getUserPhotos()
    }
    
    @IBAction private func userSegmentedControlSelected(_ sender: UISegmentedControl) {
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

// MARK: - Table View DataSource
extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userSegmentControl.selectedSegmentIndex {
        case 2:
            return userDetailViewModel?.numberOfRowsForCollectionIn(section: section) ?? 0
            
        default:
            return userDetailViewModel?.numberOfRowsIn(section: section) ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(userSegmentControl.selectedSegmentIndex)
        if userSegmentControl.selectedSegmentIndex == 2 {
            guard let data = userDetailViewModel?.collectionDataForCell(at: indexPath.row) else {
                fatalError("Failed to get data")
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCollectionTableViewCell.identifier) as? UserCollectionTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
        } else {
            guard let data = userDetailViewModel?.dataForCell(at: indexPath.row) else {
                fatalError("Failed to get data")
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
        }
    }
}

// MARK: - Table View Delegate
extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch userSegmentControl.selectedSegmentIndex {
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let collectionsDisplayViewController = storyboard.instantiateViewController(withIdentifier: "CollectionsDisplayViewController") as? CollectionsDisplayViewController else { return }
            
        default:
            break
        }
    }
}

// MARK: - View Model Delegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func reloadTableData() {
        self.userTableView.reloadData()
    }
}
