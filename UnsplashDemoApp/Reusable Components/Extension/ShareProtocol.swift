//
//  ShareProtocol.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import Foundation
import UIKit

protocol ShareProtocol {
    func shareUnsplash(viewController: UIViewController)
}

extension ShareProtocol {
    func shareUnsplash(viewController: UIViewController) {
        // Setting description
        let firstActivityItem = "Unsplash is a great app with beautiful images"

        // Setting url
        guard let secondActivityItem = NSURL(string: "https://unsplash.com") else { return }
        
        // If you want to use an image
        guard let image = UIImage(named: "logo.white_2") else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}
