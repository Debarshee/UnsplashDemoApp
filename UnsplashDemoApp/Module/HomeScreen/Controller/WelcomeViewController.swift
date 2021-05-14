//
//  WelcomeViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/14/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func startButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
