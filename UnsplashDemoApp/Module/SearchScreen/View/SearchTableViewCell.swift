//
//  SearchTableViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/10/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell, ViewReusable {
    
    @IBOutlet private weak var photoImageViiew: UIImageView!
    @IBOutlet private weak var photoNameLabel: UILabel!
    
    func configure(configurator: SearchTableCellViewModel) {
        photoImageViiew.downloadImage(with: configurator.image)
        photoNameLabel.text = configurator.title
    }
}
