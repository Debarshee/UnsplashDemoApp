//
//  ProfileTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/22/21.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, ViewReusable {
    @IBOutlet private weak var profileCellImageView: UIImageView!
    @IBOutlet private weak var profileImageCellLabel: UILabel!
    
    func configure(configurator: ProfileTableCellViewModel) {
        profileCellImageView.downloadImage(with: configurator.photoImage)
        profileImageCellLabel.text = configurator.photoImageText
    }
}
