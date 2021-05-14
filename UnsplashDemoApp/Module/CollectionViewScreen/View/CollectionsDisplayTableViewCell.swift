//
//  CollectionsDisplayTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import UIKit

class CollectionsDisplayTableViewCell: UITableViewCell, ViewReusable {

    @IBOutlet private weak var photoImageView: UIImageView!
    
    func configure(configurator: CollectionDisplayCellViewModel) {
        photoImageView.downloadImage(with: configurator.photoImage)
    }
}
