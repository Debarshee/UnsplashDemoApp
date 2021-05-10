//
//  PhotoInfoViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/9/21.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet private weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
