//
//  HomeTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell, ViewReusable {
    
    @IBOutlet private weak var topicPhotoImageView: UIImageView!
    @IBOutlet private weak var topicPhotoLabel: UILabel!
    
    func configure(configurator: HomeTableCellViewModel) {
        topicPhotoImageView.downloadImage(with: configurator.image)
        topicPhotoLabel.text = configurator.name
    }
}
