//
//  UserDetailViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet private weak var noCellsView: UIView!
    @IBOutlet private weak var noCellsImageView: UIImageView!
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
            self.userTableView.tableFooterView = UIView()
            self.userTableView.register(UINib(nibName: UserCollectionTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: UserCollectionTableViewCell.identifier)
        }
    }
    
    var userDetailViewModel: UserDetailViewModel?
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDetailViewModel != nil {
            noCellsView.isHidden = true
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
            userDetailViewModel?.getUserPhotos(pageNo: currentPage)
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
            guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            loginViewController.delegate = self
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    @IBAction private func userSegmentedControlSelected(_ sender: UISegmentedControl) {
        switch userSegmentControl.selectedSegmentIndex {
        case 0:
            currentPage = 1
            noCellsView.isHidden = true
            userDetailViewModel?.getUserPhotos(pageNo: currentPage)
            
        case 1:
            currentPage = 1
            noCellsView.isHidden = true
            userDetailViewModel?.getUserLikes(pageNo: currentPage)
        
        case 2:
            currentPage = 1
            noCellsView.isHidden = true
            userDetailViewModel?.getUserCollections(pageNo: currentPage)
            
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
            let count = userDetailViewModel?.numberOfRowsForCollectionIn() ?? 0
            if count < 1 {
                self.noCellsView.isHidden = false
            }
            return count
            
        case 1:
            return userDetailViewModel?.numberOfRowsIn() ?? 0
        
        default:
            return userDetailViewModel?.numberOfRowsIn() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch userSegmentControl.selectedSegmentIndex {
        case 2:
//            if indexPath.row == (userDetailViewModel?.numberOfRowsForCollectionIn() ?? 0) - 1 {
//                currentPage += 1
//                userDetailViewModel?.extendedUserCollections(pageNo: currentPage)
//            }
            guard let data = userDetailViewModel?.collectionDataForCell(at: indexPath.row) else {
                fatalError("Failed to get data")
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCollectionTableViewCell.identifier) as? UserCollectionTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
            
        case 1:
//            if indexPath.row == (userDetailViewModel?.numberOfRowsIn() ?? 0) - 1 {
//                currentPage += 1
//                userDetailViewModel?.extendedUserLikes(pageNo: currentPage)
//            }
            guard let data = userDetailViewModel?.dataForCell(at: indexPath.row) else {
                fatalError("Failed to get data")
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
            
        default:
//            if indexPath.row == (userDetailViewModel?.numberOfRowsIn() ?? 0) - 1 {
//                currentPage += 1
//                userDetailViewModel?.extendedUserPhotos(pageNo: currentPage)
//            }
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
            guard let data = userDetailViewModel?.collectionDataForCell(at: indexPath.row) else { return }
            let collection = userDetailViewModel?.passCollectionData(collectionData: data.collectionId)
            collectionsDisplayViewController.collectionDisplayViewModel = collection
            self.navigationController?.pushViewController(collectionsDisplayViewController, animated: true)
            
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { return }
            guard let data = userDetailViewModel?.dataForCell(at: indexPath.row) else { return }
            let photo = userDetailViewModel?.passPhotoData(photoData: data.photoData)
            photoViewController.photoDisplayViewModel = photo
            self.navigationController?.pushViewController(photoViewController, animated: true)
        }
    }
}

// MARK: - View Model Delegate
extension UserDetailViewController: UserDetailViewModelDelegate {
    func reloadTableData() {
        self.userTableView.reloadData()
    }
}

extension UserDetailViewController: LoginViewControllerDelegate {
    func passUserData(user: UserDetailViewModel) {
        userDetailViewModel = user
        self.viewDidLoad()
    }
}
