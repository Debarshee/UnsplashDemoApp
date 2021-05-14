//
//  ReviewViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/13/21.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var openReviewButton: UIButton!
    @IBOutlet private weak var openUnsplashButton: UIButton!
    @IBOutlet private weak var openLicenseButton: UIButton!
    @IBOutlet private weak var recommendUnsplashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func doneButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func openReviewButtonClicked(_ sender: UIButton) {
        if let url = URL(string: "https://apps.apple.com/us/app/unsplash/id1290631746#see-all/reviews") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction private func openUnsplashButtonClicked(_ sender: UIButton) {
        if let url = URL(string: "https://unsplash.com") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction private func openLicenseButtonClicked(_ sender: UIButton) {
        if let url = URL(string: "https://unsplash.com/license") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction private func recommendUnsplashButtonClicked(_ sender: UIButton) {
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
        self.present(activityViewController, animated: true, completion: nil)
    }
}
