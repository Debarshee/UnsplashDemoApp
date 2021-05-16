//
//  LoginViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/16/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginContainerView.layer.cornerRadius = 20
        loginContainerView.clipsToBounds = true
    }
    
    @IBAction private func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func forgotPasswordButtonClicked(_ sender: UIButton) {
    }
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
    }
}
