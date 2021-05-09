//
//  PhotoViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    
    var photoDetailViewModel: PhotoDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.downloadImage(with: photoDetailViewModel?.photoImage)
    }
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
