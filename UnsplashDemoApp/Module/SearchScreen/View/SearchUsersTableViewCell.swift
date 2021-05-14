//
//  SearchUsersTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import UIKit

class SearchUsersTableViewCell: UITableViewCell, ViewReusable {
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userFullNameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var firstImageView: UIImageView!
    @IBOutlet private weak var secondImageView: UIImageView!
    @IBOutlet private weak var thirdImageView: UIImageView!
    
    func configure(configurator: SearchUserTableCellViewModel) {
        profileImageView.downloadImage(with: configurator.profileImage)
        profileImageView.layer.cornerRadius = profileImageView.layer.frame.width / 2
        profileImageView.clipsToBounds = true
        userFullNameLabel.text = configurator.name
        usernameLabel.text = configurator.username
        firstImageView.downloadImage(with: configurator.firstSubImage)
        secondImageView.downloadImage(with: configurator.secondSubImage)
        thirdImageView.downloadImage(with: configurator.thirdSubImage)
    }
}
