//
//  UserCollectionTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import UIKit

class UserCollectionTableViewCell: UITableViewCell, ViewReusable {

    @IBOutlet private weak var userCollectionMainImageView: UIImageView!
    @IBOutlet private weak var userCollectionFirstImageView: UIImageView!
    @IBOutlet private weak var userCollectionSecondImageView: UIImageView!
    @IBOutlet private weak var userCollectionTitleLabel: UILabel!
    @IBOutlet private weak var collectionNumberOfPhotosLabel: UILabel!
    @IBOutlet private weak var firstTagLabel: UILabel!
    @IBOutlet private weak var secondTagLabel: UILabel!
    @IBOutlet private weak var thirdTagLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(configurator: UserCollectionTableViewCellViewModel) {
        userCollectionMainImageView.downloadImage(with: configurator.mainImage)
        userCollectionFirstImageView.downloadImage(with: configurator.firstSubImage)
        userCollectionSecondImageView.downloadImage(with: configurator.secondSubImage)
        userCollectionTitleLabel.text = configurator.userCollectionTitle
        collectionNumberOfPhotosLabel.text = configurator.userCollectionPhotoNumber
        firstTagLabel.text = configurator.userCollectionTag1
        secondTagLabel.text = configurator.userCollectionTag2
        thirdTagLabel.text = configurator.userCollectionTag3
    }
}
