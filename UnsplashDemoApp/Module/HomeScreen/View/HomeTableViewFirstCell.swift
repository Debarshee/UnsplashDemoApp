//
//  HomeTableViewFirstCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/17/21.
//

import UIKit

class HomeTableViewFirstCell: UITableViewCell, ViewReusable {
    @IBOutlet private weak var topicPhotoImageView: UIImageView!
    @IBOutlet private weak var topicPhotoLabel: UILabel!
    
    func configure(configurator: HomeTableCellViewModel) {
        topicPhotoImageView.downloadImage(with: configurator.image)
        topicPhotoLabel.text = configurator.name
    }
}
