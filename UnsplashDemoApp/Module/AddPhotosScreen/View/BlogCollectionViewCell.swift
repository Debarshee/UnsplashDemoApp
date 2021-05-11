//
//  BlogCollectionViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/11/21.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell, ViewReusable {
    
   @IBOutlet private weak var blogPhotoImageView: UIImageView!
    @IBOutlet private weak var blogPhotoLabel: UILabel!
    @IBOutlet private weak var blogPhotoUser: UILabel!

    func configure(configurator: BlogCollectionCellViewModel) {
        blogPhotoImageView.downloadImage(with: configurator.image)
        blogPhotoLabel.text = configurator.title
        blogPhotoUser.text = configurator.name
    }
}
