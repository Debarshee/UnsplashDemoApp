//
//  SignUpViewController.swift
//  UnsplashDemoApp
//
//  Created by Debarshee on 5/18/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var backToLoginButton: UIButton!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var signUpContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        signUpContainerView.layer.cornerRadius = 20
        signUpContainerView.clipsToBounds = true
    }
    
    @IBAction private func backToLoginButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
    }
}
