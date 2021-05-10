//
//  UserTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import UIKit

class UserTableViewCell: UITableViewCell, ViewReusable {
    
    @IBOutlet private weak var userPhotoImageView: UIImageView!
    
    func configure(configurator: UserTableCellViewModel) {
        userPhotoImageView.downloadImage(with: configurator.photoUrl)
    }
}
