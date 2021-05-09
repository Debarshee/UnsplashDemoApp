//
//  HomeCollectionViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell, ViewReusable {
    
    @IBOutlet private weak var topicNameLabel: UILabel!
    
    func configure(configurator: HomeCollectionCellViewModel) {
        topicNameLabel.text = configurator.title
    }
}
