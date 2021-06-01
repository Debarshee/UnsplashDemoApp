//
//  ProfileViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/22/21.
//

import Firebase
import FirebaseDatabase
import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var profileViewContainer: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var profileScreenImageView: UIImageView!
    @IBOutlet private weak var profileNameLabel: UILabel!
    @IBOutlet private weak var profileLocationLabel: UILabel!
    @IBOutlet private weak var profileLinkLabel: UILabel!
    @IBOutlet private weak var profileSegmentControl: UISegmentedControl!
    @IBOutlet private weak var profileTableView: UITableView! {
        didSet {
            self.profileTableView.dataSource = self
        }
    }
    lazy var profileViewModel = ProfileViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Blur effect to image view
        let darkBlur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = profileScreenImageView.bounds
        profileScreenImageView.addSubview(blurView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    @IBAction private func profileSegmentControlSelected(_ sender: UISegmentedControl) {
        switch profileSegmentControl.selectedSegmentIndex {
        case 0:
            profileViewModel.getPhotoDataFromFireBase()
            
        case 1:
            profileViewModel.getPhotoDataFromFireBase()
            
        case 2:
            profileViewModel.getPhotoDataFromFireBase()
            
        default:
            break
        }
    }
    
    private func getData() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                self.profileViewModel.getPhotoDataFromFireBase()
            } else {
                let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
                loginViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
    }
}
// MARK: - Tableview DataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileSegmentControl.selectedSegmentIndex {
        case 0:
            return profileViewModel.numberOfRowForPhotos()
            
        case 1:
            return profileViewModel.numberOfRowForLikedPhotos()
            
        case 2:
            return 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileSegmentControl.selectedSegmentIndex {
        case 0:
            let data = profileViewModel.dataForPhotoCell(at: indexPath.row)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
            
        case 1:
            let data = profileViewModel.dataForLikeCell(at: indexPath.row)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else {
                fatalError("Failed to dequeue the cell")
            }
            cell.configure(configurator: data)
            return cell
            
        case 2:
            return UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func reloadTable() {
        self.profileTableView.reloadData()
    }
}
