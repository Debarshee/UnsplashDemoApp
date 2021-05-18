//
//  HomeCollectionViewCell.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/7/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell, ViewReusable {
    
    @IBOutlet private weak var topicNameLabel: UILabel!
    @IBOutlet private weak var selectedIndicatorView: UIView!
    var cellIsNotSelected = true
    
    func configure(configurator: HomeCollectionCellViewModel) {
        topicNameLabel.text = configurator.title
        selectedIndicatorView.isHidden = cellIsNotSelected
    }
}
